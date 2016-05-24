Berg::Container.namespace "persistence" do |container|
  container.register "commands.create_post" do
    container["persistence.rom"].command(:posts)[:create]
  end

  container.register "commands.create_user" do
    container["persistence.rom"].command(:users)[:create]
  end

  container.register "commands.update_post" do
    container["persistence.rom"].command(:posts)[:update]
  end

  container.register "commands.create_project" do
    container["persistence.rom"].command(:projects)[:create]
  end

  container.register "commands.update_project" do
    container["persistence.rom"].command(:projects)[:update]
  end
end
