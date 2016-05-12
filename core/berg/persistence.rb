Berg::Container.namespace "persistence" do |container|
  container.register "commands.update_post" do
    container["persistence.rom"].command(:posts)[:update]
  end

  container.register "commands.create_post" do
    container["persistence.rom"].command(:posts)[:create]
  end
end
