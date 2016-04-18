module Main
  class Container < Dry::Web::Container
    require root.join("core/icelab_com_au/container")
    import IcelabComAu::Container

    configure do |config|
      config.root = Pathname(__FILE__).join("../..").realpath.dirname.freeze

      config.auto_register = %w[
        lib/main/operations
        lib/main/validation
        lib/main/views
      ]
    end

    load_paths! "lib", "core"
  end
end
