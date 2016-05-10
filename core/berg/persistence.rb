Berg::Container.namespace "persistence" do |container|
  container.register "commands.update_post" do
    container["persistence.rom"].command(:posts)[:update]
  end
end
