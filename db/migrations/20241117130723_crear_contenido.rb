Sequel.migration do
  up do
    run "CREATE TYPE tipo_contenido AS ENUM ('cancion', 'podcast', 'episodio')"

    create_table(:contenidos) do
      primary_key :id
      column :tipo, :tipo_contenido, null: false
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:contenidos)
    run 'DROP TYPE tipo_contenido'
  end
end
