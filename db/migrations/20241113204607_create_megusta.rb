Sequel.migration do
  up do
    create_table(:megustas) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, null: false, type: Integer, on_delete: :cascade
      foreign_key :id_cancion, :canciones, null: false, type: Integer, on_delete: :cascade

      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:megustas)
  end
end
