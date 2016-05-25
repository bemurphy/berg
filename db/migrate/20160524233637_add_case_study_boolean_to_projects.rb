ROM::SQL.migration do
  up do
    add_column :projects, :case_study, TrueClass, default: false, null: false
  end

  down do
    drop_column :projects, :case_study
  end
end
