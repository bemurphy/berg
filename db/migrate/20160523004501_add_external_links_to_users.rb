ROM::SQL.migration do
  up do
    add_column :users, :website, String, null: true, default: ""
    add_column :users, :twitter, String, null: true, default: ""
  end

  down do
    drop_column :users, :website
    drop_column :users, :twitter
  end
end
