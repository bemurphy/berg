require "logger"

IcelabComAu::Container.finalize :logger do |container|
  container.register :logger, Logger.new(container.root.join("log/#{container.config.env}.log"))
end
