require 'httparty'
require 'json'
require 'fileutils'
require_relative "walkthrough_awanllm/cli"
require_relative "walkthrough_awanllm/version"
require_relative "walkthrough_awanllm/railtie" if defined?(Rails)

module WalkthroughAwanllm
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
      commits = split_by_commits(activities)

      # Read the last processed commit hash from file
      last_commit_file = "last_processed_commit.txt"
      last_processed_commit = read_last_processed_commit(last_commit_file)

      # Find the index of the last processed commit
      start_index = commits.index { |commit| commit.include?(last_processed_commit) }
      start_index = start_index.nil? ? 0 : start_index + 1  # Start from the next commit

      # Extract new commits
      new_commits = commits[start_index..-1] || []
      return if new_commits.empty?

      prompt_template = <<~PROMPT
        Here is a log of activities for a specific git commit: {{commit}}.
        Using this log, generate a detailed walkthrough for this commit. This walkthrough should be narrated from the first-person perspective of the developer, resembling a personal diary or story. It must include the following:
        - Personal Insights: Capture the developer's thoughts, decisions, and reflections during this commit.
        - Challenges: Describe any difficulties or obstacles faced and how they were resolved or worked around.
        - Technical Details: Provide detailed explanations of the technical aspects and steps involved, including relevant code snippets.
        - Reasoning: Explain the reasoning behind major decisions during this commit, such as choosing specific tools, technologies, or methods.
        - Step-by-Step Process: Offer a structured guide through the entire commit process.
        - Lessons Learned: Conclude with insights or lessons learned from this commit, including what could be done differently in future commits.
        Ensure the walkthrough is thorough, engaging, and informative, offering a deep dive into the developer's journey during this commit.
      PROMPT

      walkthrough = ""

      new_commits.each do |commit|
        prompt = prompt_template.gsub("{{commit}}", commit)
        options = {
          temperature: 0.7,
          top_p: 0.9,
          max_tokens: 2048  # Adjust if your model supports more tokens
        }

        response = generate_content(nil, prompt, options)
        commit_walkthrough = response['choices'][0]['text']

        walkthrough += commit_walkthrough + "\n\n"
      end

      # Append to the file only if it exists
      if File.exist?("walkthrough.md")
        File.open("walkthrough.md", "a") do |file|
          file.puts("\n")
          file.puts(walkthrough)
        end
      else
        File.write("walkthrough.md", walkthrough)
      end

      # Update the last processed commit hash
      update_last_processed_commit(last_commit_file, extract_commit_hash(new_commits.last))
    end


    # Method to split the log by git commits
    def split_by_commits(log_content)
      log_content.scan(/#### Commit Details:.*?(?=(### \[|\z))/m).map(&:strip)
    end

    # Read the last processed commit from file
    def read_last_processed_commit(file)
      return nil unless File.exist?(file)
      File.read(file).strip
    end

    # Update the last processed commit in file
    def update_last_processed_commit(file, commit_hash)
      File.write(file, commit_hash)
    end

    # Extract the commit hash from a commit section
    def extract_commit_hash(commit_section)
      match = commit_section.match(/#### Commit Details: (\w+)/)
      match[1] if match
    end

    def self.activate!
      require 'fileutils'
      require 'json'

      # Run the installation script
      if File.exist?('config/awanllm_config.json')
        puts 'Walkthrough_AwanLLM gem is already configured.'
      else
        ruby_version = RUBY_VERSION.split('.').first(3).join('.')
        path_to_script = "./vendor/bundle/ruby/#{ruby_version}/gems/walkthrough_awanllm-0.2.12/bin/setup_awanllm.rb"
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
end
