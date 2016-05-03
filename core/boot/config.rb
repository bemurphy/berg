Berg::Container.finalize(:config) do |container|
  require "berg/config"
  container.register "config", Berg::Config.load(container.root, "application", container.config.env)
end
