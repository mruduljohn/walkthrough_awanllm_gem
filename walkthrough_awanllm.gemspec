# frozen_string_literal: true

require_relative "lib/walkthrough_awanllm/version"

Gem::Specification.new do |spec|
  spec.name        = "walkthrough_awanllm"
  spec.version     = WalkthroughAwanllm::VERSION
  spec.authors     = ["Mrudul John"]
  spec.email       = ["mrudulmathews@gmail.com"]

  spec.summary     = "A Ruby gem to Generate Project Development Walkthrough with the AwanLLM API."
  spec.description = "A Ruby gem to generate a walkthrough the project lifecycle with the AwanLLM API for generating and retrieving content. Please feel free to update the gem with your updates"
  spec.homepage    = "https://github.com/mruduljohn/Walkthrough_awanllm_gem"
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile]) ||
      f.match(/walkthrough_awanllm-\d+\.\d+\.\d+\.gem/)
    end
  end + [
    "lib/walkthrough_awanllm.rb",
    "lib/walkthrough_awanllm/railtie.rb",
    "lib/walkthrough_awanllm/version.rb",
    "bin/setup_awanllm.rb", # Include setup_awanllm.rb file
    "lib/tasks/generate_walkthrough.rake", # Include generate_walkthrough.rake file
  ]

  spec.bindir = "bin"
  spec.executables = ["setup_awanllm.rb"]
  spec.require_paths = ["lib"]
  spec.add_dependency "httparty"
  spec.add_dependency "thor"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.post_install_message = <<-MESSAGE
    Thank you for installing the Walkthrough_AwanLLM gem!
    To complete the setup, please run the following command:
    ruby ./vendor/bundle/ruby/#{RUBY_VERSION.split('.').first(3).join('.')}/gems/walkthrough_awanllm-#{spec.version}/bin/setup_awanllm.rb
  MESSAGE
end
