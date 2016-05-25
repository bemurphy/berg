ROM::SQL.migration do
  up do
    create_table :about_page_people do
      Integer :position, null: false
      Integer :person_id, null: false
    end
  end

  down do
    drop_table :about_page_people
  end
end
