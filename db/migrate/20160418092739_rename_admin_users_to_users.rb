ROM::SQL.migration do
  change do
    rename_table :admin_users, :users
  end
end
