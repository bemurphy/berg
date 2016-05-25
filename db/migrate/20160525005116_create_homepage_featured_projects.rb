ROM::SQL.migration do
  up do
    create_table :homepage_featured_projects do
      primary_key :id
      Integer :project_id, null: false
      Integer :position, null: false
    end
  end

  down do
    drop_table :homepage_featured_projects
  end
end
