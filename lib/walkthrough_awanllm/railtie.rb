
require 'rails/railtie'
require 'fileutils'

module AwanLLM
  class Railtie < Rails::Railtie
    initializer "awanllm.track_activity" do |app|
      app.config.middleware.use AwanLLM::Tracker
    end
  end
end

# Middleware to track activities
module AwanLLM
  class Tracker
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      log_activity(env)
      [status, headers, response]
    end

    private

    def log_activity(env)
      FileUtils.mkdir_p("log")
      File.open("log/awanllm_activity.log", "a") do |file|
        file.puts("[#{Time.now}] #{env['REQUEST_METHOD']} #{env['PATH_INFO']}")
      end
    end
  end
end
