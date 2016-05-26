ROM::SQL.migration do
  up do
    rename_column :posts, :author_id, :person_id
  end

  down do
    rename_column :posts, :person_id, :author_id
  end
end
