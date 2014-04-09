Sequel.migration do
  up do
    create_table(:qr_codes) do
      primary_key :id
      String :slug, :null => false
      Integer :license_id
    end
  end

  down do
    drop_table(:qr_codes)
  end
end