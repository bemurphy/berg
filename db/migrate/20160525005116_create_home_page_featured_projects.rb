ROM::SQL.migration do
  up do
    create_table :home_page_featured_projects do
      primary_key :id
      Integer :position, null: false
      Integer :project_id, null: false
    end
  end

  down do
    drop_table :home_page_featured_projects
  end
end
