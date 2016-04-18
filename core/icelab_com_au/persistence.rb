IcelabComAu::Container.namespace "persistence" do |container|
  container.register "create_admin_user" do
    container["persistence.rom"].command(:admin_users)[:create]
  end
end
