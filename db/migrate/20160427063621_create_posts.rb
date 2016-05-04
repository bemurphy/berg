ROM::SQL.migration do
  up do
    create_table :posts do
      primary_key :id
      String :title, null: false
      String :body
      String :slug, unique: true
      String :state
      Integer :author_id
      DateTime :published_at
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<-SQL
      CREATE TRIGGER set_updated_at_on_posts
        BEFORE UPDATE ON posts FOR EACH ROW
        EXECUTE PROCEDURE set_updated_at_column();
    SQL
  end

  down do
    run <<-SQL
      DROP TRIGGER IF EXISTS set_updated_at_on_posts ON posts;
    SQL

    drop_table :posts
  end
end
