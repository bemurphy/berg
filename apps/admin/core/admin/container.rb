module Admin
  class Container < Dry::Web::Container
    require root.join("core/berg/container")
    import Berg::Container

    configure do |config|
      config.root = Pathname(__FILE__).join("../..").realpath.dirname.freeze

      config.auto_register = %w[
        lib/admin/authentication
        lib/admin/operations
        lib/admin/validation
        lib/admin/views
      ]
    end

    load_paths! "lib", "core"
  end
end
