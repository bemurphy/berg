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

  container.register "commands.update_home_page_featured_items" do
    container["persistence.rom"].command(:home_page_featured_items)[:update]
  end
end
