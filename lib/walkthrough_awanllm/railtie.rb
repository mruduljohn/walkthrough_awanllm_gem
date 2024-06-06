# lib/awanllm/railtie.rb

require 'rails/railtie'
require 'fileutils'

module AwanLLM
  class Railtie < Rails::Railtie
    initializer "awanllm.track_activity" do |app|
      app.config.middleware.use AwanLLM::Tracker

      setup_git_hook
    end

    private

    def setup_git_hook
      git_hook_script_path = Rails.root.join('.git', 'hooks', 'post-commit')
      git_hook_script_content = <<-SCRIPT
#!/bin/bash
RAILS_ROOT="#{Rails.root}"
cd $RAILS_ROOT
bundle exec rails runner "AwanLLM::Tracker.new.update_activity_log"
      SCRIPT

      # Write the Git hook script
      File.open(git_hook_script_path, "w") { |f| f.write(git_hook_script_content) }
      FileUtils.chmod(0755, git_hook_script_path)

      # Inform the user about the setup
      puts "Git hook for tracking activity log updates has been set up: #{git_hook_script_path}"
    end
  end
end

# Middleware to track activities
module AwanLLM
  class Tracker
    def initialize(app = nil)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      [status, headers, response]
    end

    def update_activity_log
      log_file_path = Rails.root.join('log', 'awanllm_activity.log')
      FileUtils.mkdir_p(File.dirname(log_file_path))

      # Get the latest commit details
      commit_details = `git log -1 --pretty=format:"%H %an %ad %s" --date=iso`
      file_changes = `git diff-tree --no-commit-id --name-status -r HEAD`

      File.open(log_file_path, "a") do |file|
        file.puts("### [#{Time.now}] Activity Log")
        file.puts("#### Commit Details: #{commit_details.strip}")
        file.puts("#### File Changes:")
        file_changes.each_line do |line|
          file.puts("- #{line.strip}")
        end
        file.puts("\n")
      end
    end
  end
end
