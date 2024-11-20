Sequel.migration do
  up do
    alter_table(:reproducciones) do
      drop_foreign_key :id_cancion
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_contenido, :contenidos, null: false, type: Integer, on_delete: :cascade
    end
  end

  down do
    alter_table(:reproducciones) do
      drop_foreign_key :id_contenido
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_cancion, :canciones, null: false, type: Integer, on_delete: :cascade
    end
  end
end
