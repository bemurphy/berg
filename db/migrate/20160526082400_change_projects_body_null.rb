ROM::SQL.migration do
  change do
    alter_table(:projects) do
      set_column_allow_null :body
    end
  end
end
