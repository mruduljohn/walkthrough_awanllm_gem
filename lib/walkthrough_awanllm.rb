require 'httparty'
require 'json'
require 'walkthorugh_awanllm/railtie' if defined?(Rails)
require_relative "walkthrough_awanllm/cli"
require_relative "walkthrough_awanllm/version"

class AwanLLM
  include HTTParty
  base_uri 'https://api.awanllm.com/v1'

  def initialize(api_key = nil, model_name = nil)
    if api_key.nil? || model_name.nil?
      config = JSON.parse(File.read("config/awanllm_config.json"))
      @api_key = config["api_key"]
      @model_name = config["model_name"]
    else
      @api_key = api_key
      @model_name = model_name
    end

    @headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@api_key}"
    }
  end

  def generate_content(messages = nil, prompt = nil, options = {})
    payload = { model: @model_name }
    payload[:messages] = messages if messages
    payload[:prompt] = prompt if prompt
    payload.merge!(options)

    response = self.class.post('/completions', headers: @headers, body: payload.to_json)
    handle_response(response)
  end

  def retrieve_content(content_id)
    response = self.class.get("/completions/#{content_id}", headers: @headers)
    handle_response(response)
  end

  def generate_walkthrough
    activities = File.read("log/awanllm_activity.log")
    prompt = "Here is a log of activities:\n#{activities}\nGenerate a detailed walkthrough based on these activities. It should include the steps taken and the expected outcomes."

    options = {
      temperature: 0.7,
      top_p: 0.9,
      max_tokens: 1024
    }

    response = generate_content(nil, prompt, options)
    walkthrough = response['choices'][0]['text']

    File.open("walkthrough.md", "w") do |file|
      file.write(walkthrough)
    end
  end

  def self.activate!
    require 'fileutils'
    require 'json'

    # Run the installation script
    if File.exist?('config/awanllm_config.json')
      puts 'Walkthrough_AwanLLM gem is already configured.'
    else
      ruby_version = RUBY_VERSION.split('.').first(2).join('.')
      path_to_script = "./vendor/bundle/ruby/#{ruby_version}/gems/walkthrough_awanllm-0.1.16/bin/setup_awanllm.rb"
      system("ruby #{path_to_script}")
    end
  end

  # Activate the gem automatically after installation
  activate!

  private

  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      error_message = JSON.parse(response.body)['error']['message'] rescue response.message
      raise "Error: #{response.code} - #{error_message}"
    end
  end
end
