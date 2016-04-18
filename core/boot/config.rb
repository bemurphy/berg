IcelabComAu::Container.finalize(:config) do |container|
  require "icelab_com_au/config"
  container.register "config", IcelabComAu::Config.load(container.root, "application", container.config.env)
end
