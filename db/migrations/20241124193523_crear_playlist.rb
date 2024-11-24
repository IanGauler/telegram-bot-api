Sequel.migration do
  up do
    create_table(:playlists) do
      primary_key :id
      foreign_key :id_usuario, :usuarios, null: false, type: String, on_delete: :cascade
      foreign_key :id_contenido, :contenidos, null: false, type: Integer, on_delete: :cascade

      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:playlists)
  end
end
