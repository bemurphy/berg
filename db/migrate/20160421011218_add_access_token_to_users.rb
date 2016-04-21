ROM::SQL.migration do
  change do
    alter_table :users do
      add_column :access_token, String
      add_column :access_token_expiration, DateTime
    end
  end
end
