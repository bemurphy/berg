ROM::SQL.migration do
  up do
    add_column :posts, :teaser, String, null: false, default: ""
  end

  down do
    drop_column :posts, :teaser
  end
end
