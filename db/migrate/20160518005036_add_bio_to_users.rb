ROM::SQL.migration do
  up do
    add_column :users, :bio, String, null: true, default: ""
  end

  down do
    drop_column :users, :bio
  end
end
