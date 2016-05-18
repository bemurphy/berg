ROM::SQL.migration do
  up do
    create_table :projects do
      primary_key :id
      String :title, null: false
      String :client, null: false
      String :url, null: false
      String :intro, null: false
      String :body, null: false
      String :tags, null: false
      String :slug, null: false, unique: true
      String :status, default: "draft"
      DateTime :published_at
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<-SQL
      CREATE TRIGGER set_updated_at_on_projects
        BEFORE UPDATE ON projects FOR EACH ROW
        EXECUTE PROCEDURE set_updated_at_column();
    SQL
  end

  down do
    run <<-SQL
      DROP TRIGGER IF EXISTS set_updated_at_on_projects ON projects;
    SQL

    drop_table :projects
  end
end
