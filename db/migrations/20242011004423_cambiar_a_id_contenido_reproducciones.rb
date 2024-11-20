Sequel.migration do
  up do
    alter_table(:reproducciones) do
      add_column :id_contenido, Integer, null: true
    end

    run <<-SQL
      UPDATE reproducciones
      SET id_contenido = (
        SELECT contenidos.id
        FROM contenidos
        WHERE contenidos.id_cancion = reproducciones.id_cancion
      )
    SQL

    alter_table(:reproducciones) do
      set_column_not_null :id_contenido
    end

    alter_table(:reproducciones) do
      drop_foreign_key :id_cancion
      drop_column :id_cancion
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_contenido, :contenidos, null: false, type: Integer, on_delete: :cascade
    end
  end

  down do
    alter_table(:reproducciones) do
      add_column :id_cancion, Integer, null: true
    end

    run <<-SQL
      UPDATE reproducciones
      SET id_cancion = (
        SELECT contenidos.id_cancion
        FROM contenidos
        WHERE contenidos.id = reproducciones.id_contenido
      )
    SQL

    alter_table(:reproducciones) do
      set_column_not_null :id_cancion
    end

    alter_table(:reproducciones) do
      drop_foreign_key :id_contenido
      drop_column :id_contenido
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_cancion, :canciones, null: false, type: Integer, on_delete: :cascade
    end
  end
end
