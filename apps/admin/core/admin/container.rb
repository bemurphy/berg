module Admin
  class Container < Dry::Web::Container
    require root.join("core/berg/container")
    import Berg::Container

    configure do |config|
      config.name = :admin

      config.root = Pathname(__FILE__).join("../..").realpath.dirname.freeze

      config.auto_register = %w[
        lib/admin
      ]
    end

    load_paths! "lib", "core"
  end
end
