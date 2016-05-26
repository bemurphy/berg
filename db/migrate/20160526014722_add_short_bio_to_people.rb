ROM::SQL.migration do
  up do
    add_column :people, :short_bio, String, null: false, default: ""
  end

  down do
    drop_column :people, :short_bio
  end
end
