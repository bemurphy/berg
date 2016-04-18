require_relative "container"

module IcelabComAu
  Import = IcelabComAu::Container.import_module

  auto_inject = Dry::AutoInject(IcelabComAu::Container)

  HashImport = -> *keys do
    keys.each do |key|
      unless IcelabComAu::Container.key?(key)
        IcelabComAu::Container.load_component(key)
      end
    end

    auto_inject.hash[*keys]
  end

  def self.Import(*args)
    Import[*args]
  end
end
