ROM::SQL.migration do
  up do
    create_table :taggings do
      primary_key :id
      Integer :post_id, null: false
      Integer :tag_id, null: false
    end
  end

  down do
    drop_table :posts
  end
end

