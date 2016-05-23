ROM::SQL.migration do
  up do
    add_column :users, :job_title, String, null: true, default: ""
  end

  down do
    drop_column :users, :job_title
  end
end
