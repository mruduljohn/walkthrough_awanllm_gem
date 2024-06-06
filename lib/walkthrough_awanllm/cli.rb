# lib/walkthrough_awanllm/cli.rb

require 'thor'

module WalkthroughAwanllm
  class CLI < Thor
    desc "generate_walkthrough", "Generate the walkthrough.md file"
    def generate_walkthrough
      awanllm = AwanLLM.new
      awanllm.generate_walkthrough
      puts "Walkthrough generated successfully!"
    end
  end
end
