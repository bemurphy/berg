require_relative "container"

module Admin
  Import = Admin::Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end
