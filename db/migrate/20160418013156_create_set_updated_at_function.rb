ROM::SQL.migration do
  up do
    sql = <<-SQL
      CREATE OR REPLACE FUNCTION set_updated_at_column() RETURNS TRIGGER AS $$
      BEGIN
        NEW.updated_at = CURRENT_TIMESTAMP;
        RETURN NEW;
      END;
      $$ language 'plpgsql';
    SQL
    run sql
  end

  down do
    run "DROP FUNCTION IF EXISTS set_updated_at_column();"
  end
end
