# frozen_string_literal: true

require_relative "lib/walkthrough_awanllm/version"

Gem::Specification.new do |spec|
  spec.name = "walkthrough_awanllm"
  spec.version = WalkthroughAwanllm::VERSION
  spec.authors = ["Mrudul John"]
  spec.email = ["mrudulmathews@gmail.com"]

  spec.summary       = "A Ruby gem to Generate Project Development Walkthrough with the AwanLLM API."
  spec.description   = "{UNDER DEVELOPMENT NOT FOR USE YET}A Ruby gem to generate a walkthrough the project lifecycle with the AwanLLM API for generating and retrieving content."
  spec.homepage      = "https://github.com/mruduljohn/Walkthrough_awanllm_gem"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end + [
    "lib/walkthrough_awanllm.rb",
    "lib/walkthrough_awanllm/railtie.rb",
    "lib/walkthrough_awanllm/version.rb",
    "bin/setup_awanllm.rb", # Include setup_awanllm.rb file
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
    ruby ./vendor/bundle/ruby/#{RUBY_VERSION.split('.').first(3).join('.')}/gems/walkthrough_awanllm-0.1.16/bin/setup_awanllm.rb
  MESSAGE
end
