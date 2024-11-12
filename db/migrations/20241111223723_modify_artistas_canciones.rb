Sequel.migration do
  up do
    alter_table(:canciones) do
      set_column_type :artistas, String
    end
  end

  down do
    alter_table(:canciones) do
      set_column_type :artistas, :text, array: true
    end
  end
end
