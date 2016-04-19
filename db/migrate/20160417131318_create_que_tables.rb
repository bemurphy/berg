ROM::SQL.migration do
  change do
    Berg::Container.boot! :que
    Que.migrate!
  end
end
