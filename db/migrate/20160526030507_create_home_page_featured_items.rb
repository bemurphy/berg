ROM::SQL.migration do
  up do
    create_table :home_page_featured_items do
      primary_key :id
      Integer :position, null: false
      String  :title, null: false
      String  :description, null: false
      String  :url, null: false
      String  :image_id, null: false
    end
  end

  down do
    drop_table :home_page_featured_items
  end
end
