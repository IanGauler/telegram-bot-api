Sequel.migration do
  up do
    # 1. Eliminar claves foráneas de tablas relacionadas
    alter_table(:reproducciones) do
      drop_foreign_key :id_usuario
    end

    alter_table(:megustas) do
      drop_foreign_key :id_usuario
    end

    # 2. Cambiar el tipo de la columna id en la tabla usuarios
    alter_table(:usuarios) do
      drop_column :id
      add_column :id, String, primary_key: true
    end

    # 3. Agregar de nuevo las claves foráneas con el nuevo tipo
    alter_table(:reproducciones) do
      add_foreign_key :id_usuario, :usuarios, type: String, null: false, on_delete: :cascade
    end

    alter_table(:megustas) do
      add_foreign_key :id_usuario, :usuarios, type: String, null: false, on_delete: :cascade
    end
  end

  down do
    # Revertir los cambios realizados
    alter_table(:reproducciones) do
      drop_foreign_key :id_usuario
    end

    alter_table(:megustas) do
      drop_foreign_key :id_usuario
    end

    alter_table(:usuarios) do
      drop_column :id
      add_column :id, Integer, primary_key: true
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_usuario, :usuarios, type: Integer, null: false, on_delete: :cascade
    end

    alter_table(:megustas) do
      add_foreign_key :id_usuario, :usuarios, type: Integer, null: false, on_delete: :cascade
    end
  end
end
