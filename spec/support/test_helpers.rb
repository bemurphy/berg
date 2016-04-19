module TestHelpers
  module_function

  def container
    Berg::Container
  end

  def app
    Berg::Application.app
  end

  def rom
    container["persistence.rom"]
  end

  def db_connection
    rom.gateways[:default].connection
  end
end
