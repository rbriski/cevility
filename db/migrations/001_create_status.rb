Sequel.migration do
  up do
    create_table(:statuses) do
      primary_key :id
      String :license, :null=>false
      String :status
      String :description
    end
  end

  down do
    drop_table(:statuses)
  end
end