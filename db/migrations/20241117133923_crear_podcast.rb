Sequel.migration do
  up do
    create_table(:podcasts) do
      foreign_key :id, :contenidos, primary_key: true, null: false, on_delete: :cascade
      String :titulo
      String :creador
      Integer :anio
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:podcasts)
  end
end
