ROM::SQL.migration do
  up do
    add_column :posts, :colour, String, null: false, default: ""
  end

  down do
    drop_column :posts, :colour
  end
end
