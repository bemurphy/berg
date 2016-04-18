IcelabComAu::Container.namespace "persistence" do |container|
  container.register "create_user" do
    container["persistence.rom"].command(:users)[:create]
  end
end
