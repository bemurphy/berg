require_relative "container"

module Berg
  Import = Berg::Container.import_module

  auto_inject = Dry::AutoInject(Berg::Container)

  HashImport = -> *keys do
    keys.each do |key|
      unless Berg::Container.key?(key)
        Berg::Container.load_component(key)
      end
    end

    auto_inject.hash[*keys]
  end

  def self.Import(*args)
    Import[*args]
  end
end
