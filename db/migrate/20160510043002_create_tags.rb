ROM::SQL.migration do
  up do
    create_table :tags do
      primary_key :id
      String :slug, null: false
      String :name, null: false
    end
  end

  down do
    drop_table :posts
  end
end

