Sequel.migration do
  up do
    alter_table(:reproducciones) do
      drop_foreign_key :id_usuario
    end

    alter_table(:megustas) do
      drop_foreign_key :id_usuario
    end

    alter_table(:usuarios) do
      drop_column :id
      add_column :id, String, primary_key: true
    end

    alter_table(:reproducciones) do
      add_foreign_key :id_usuario, :usuarios, type: String, null: false, on_delete: :cascade
    end

    alter_table(:megustas) do
      add_foreign_key :id_usuario, :usuarios, type: String, null: false, on_delete: :cascade
    end
  end

  down do
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
