Sequel.migration do
  up do
    create_table(:reproducciones) do
      primary_key :id
      Integer :id_usuario, null: false
      Integer :id_cancion, null: false

      Date :created_on
      Date :updated_on

      foreign_key :id_usuario, :usuarios, key: :id
      foreign_key :id_cancion, :canciones, key: :id
    end
  end

  down do
    drop_table(:reproducciones)
  end
end
