Berg::Container.namespace "persistence" do |container|
  container.register "commands.create_post" do
    container["persistence.rom"].command(:posts)[:create]
  end

  container.register "commands.create_user" do
    container["persistence.rom"].command(:users)[:create]
  end

  container.register "commands.create_person" do
    container["persistence.rom"].command(:people)[:create]
  end

  container.register "commands.update_post" do
    container["persistence.rom"].command(:posts)[:update]
  end

  container.register "commands.update_about_page_people" do
    container["persistence.rom"].command(:about_page_people)[:update]
  end
end
