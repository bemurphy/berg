ROM::SQL.migration do
  up do
    create_table :categorisations do
      primary_key :id
      Integer :post_id, null: false
      Integer :category_id, null: false
    end
  end

  down do
    drop_table :categorisations
  end
end

