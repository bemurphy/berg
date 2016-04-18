ROM::SQL.migration do
  change do
    create_table :users do
      primary_key :id
      String :email, null: false
      String :name, null: false
      String :encrypted_password, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
