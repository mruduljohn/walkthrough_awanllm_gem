#!/usr/bin/env ruby
require 'fileutils'
require 'json'

def prompt(message)
  print "#{message}: "
  gets.chomp
end

puts "Welcome to the Walkthrough_AwanLLM gem setup!"
api_key = prompt("Please enter your AwanLLM API key")

models = ["Awanllm-Llama-3-8B-Cumulus", "Meta-Llama-3-8B-Instruct", "Awanllm-Llama-3-8B-Dolfin", "Mistral-7B-Instruct"]
puts "Please select a model from the following list:"
models.each_with_index { |model, index| puts "#{index + 1}. #{model}" }
model_choice = gets.to_i - 1
model_name = models[model_choice]

# Create the config directory if it doesn't exist
config_dir = File.join(Dir.pwd, 'config')
Dir.mkdir(config_dir) unless Dir.exist?(config_dir)

config = {
  api_key: api_key,
  model_name: model_name
}

File.open(File.join(config_dir, 'awanllm_config.json'), 'w') do |file|
  file.write(JSON.pretty_generate(config))
end

puts "Configuration complete! Your settings have been saved to config/awanllm_config.json"
