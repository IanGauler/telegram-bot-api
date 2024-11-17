Sequel.migration do
  up do
    create_table(:episodios) do
      foreign_key :id, :contenidos, null: false, on_delete: :cascade
      foreign_key :id_podcast, :podcasts, null: false, on_delete: :cascade
      String :titulo
      String :participantes
      String :duracion
      Date :created_on
      Date :updated_on

      primary_key %i[id id_podcast]
    end
  end

  down do
    drop_table(:episodios)
  end
end
