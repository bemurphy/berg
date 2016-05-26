ROM::SQL.migration do
  up do
    create_table :people do
      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :twitter, null: true
      String :email, null: false
      String :bio, null: false
      String :website, null: true
      String :avatar, null: true
      String :job_title, null: true
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<-SQL
      CREATE TRIGGER set_updated_at_on_people
        BEFORE UPDATE ON people FOR EACH ROW
        EXECUTE PROCEDURE set_updated_at_column();
    SQL
  end

  down do
    run <<-SQL
      DROP TRIGGER IF EXISTS set_updated_at_on_people ON people;
    SQL

    drop_table :people
  end
end
