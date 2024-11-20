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
        WHERE contenidos.id = reproducciones.id_cancion
      )
    SQL

    alter_table(:reproducciones) do
      set_column_not_null :id_contenido
    end

    alter_table(:reproducciones) do
      drop_column :id_cancion
    end

    run <<-SQL
      ALTER TABLE reproducciones
      ADD CONSTRAINT fk_id_contenido
      FOREIGN KEY (id_contenido)
      REFERENCES contenidos(id)
      ON DELETE CASCADE;
    SQL
  end

  down do
    alter_table(:reproducciones) do
      add_column :id_cancion, Integer, null: true
    end

    run <<-SQL
      UPDATE reproducciones
      SET id_cancion = (
        SELECT contenidos.id
        FROM contenidos
        WHERE contenidos.id = reproducciones.id_contenido
      )
    SQL

    alter_table(:reproducciones) do
      set_column_not_null :id_cancion
    end

    alter_table(:reproducciones) do
      drop_column :id_contenido
    end

    run <<-SQL
      ALTER TABLE reproducciones
      ADD CONSTRAINT fk_id_cancion
      FOREIGN KEY (id_cancion)
      REFERENCES canciones(id)
      ON DELETE CASCADE;
    SQL
  end
end
