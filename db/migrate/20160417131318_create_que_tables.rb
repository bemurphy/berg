ROM::SQL.migration do
  change do
    IcelabComAu::Container.boot! :que
    Que.migrate!
  end
end
