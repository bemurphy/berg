require "bugsnag"

IcelabComAu::Container.boot! :config

Bugsnag.configure do |config|
  config.project_root = Pathname(__FILE__).join("../..").realpath.dirname.freeze
  config.release_stage = ENV.fetch("RACK_ENV", "development")
  config.notify_release_stages = ["production"]
  config.api_key = IcelabComAu::Container["config"].bugsnag_api_key
  config.logger.level = Logger::INFO
end
