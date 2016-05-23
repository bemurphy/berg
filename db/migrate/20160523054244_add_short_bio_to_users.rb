ROM::SQL.migration do
  up do
    add_column :users, :short_bio, String, null: true, default: ""
  end

  down do
    drop_column :users, :short_bio
  end
end
