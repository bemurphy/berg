ROM::SQL.migration do
  change do
    rename_table :users, :admin_users
  end
end
