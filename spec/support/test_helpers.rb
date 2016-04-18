module TestHelpers
  module_function

  def container
    IcelabComAu::Container
  end

  def app
    IcelabComAu::Application.app
  end

  def rom
    container["persistence.rom"]
  end

  def db_connection
    rom.gateways[:default].connection
  end
end
