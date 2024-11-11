Sequel.migration do
  up do
    create_table(:canciones) do
      primary_key :id
      String :titulo
      column :artistas, :text, array: true
      Integer :anio
      String :duracion
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:canciones)
  end
end
