ROM::SQL.migration do
  up do
    create_table :users do
      primary_key :id
      String :email, null: false
      String :name, null: false
      String :encrypted_password, null: false
      String :access_token, null: false
      DateTime :access_token_expiration, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<-SQL
      CREATE TRIGGER set_updated_at_on_users
        BEFORE UPDATE ON users FOR EACH ROW
        EXECUTE PROCEDURE set_updated_at_column();
    SQL
  end

  down do
    run <<-SQL
      DROP TRIGGER IF EXISTS set_updated_at_on_users ON users;
    SQL

    drop_table :users
  end
end
