Sequel.migration do
  up do
    alter_table(:reproducciones) do
      drop_foreign_key :id_cancion
    end

    alter_table(:megustas) do
      drop_foreign_key :id_cancion
    end

    alter_table(:canciones) do
      drop_column :id
      add_foreign_key :id, :contenidos, primary_key: true, on_delete: :cascade
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_cancion, :canciones, on_delete: :cascade
    end

    alter_table(:megustas) do
      add_foreign_key :id_cancion, :canciones, on_delete: :cascade
    end
  end

  down do
    alter_table(:reproducciones) do
      drop_foreign_key :id_cancion
    end

    alter_table(:megustas) do
      drop_foreign_key :id_cancion
    end

    alter_table(:canciones) do
      drop_foreign_key :id
      add_column :id, primary_key: true
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_cancion, :canciones, on_delete: :cascade
    end

    alter_table(:megustas) do
      add_foreign_key :id_cancion, :canciones, on_delete: :cascade
    end
  end
end
