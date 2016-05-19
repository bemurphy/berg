ROM::SQL.migration do
  change do
    rename_column :posts, :colour, :color
  end
end
