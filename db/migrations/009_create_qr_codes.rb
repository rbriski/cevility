Sequel.migration do
  up do
    create_table(:qr_codes) do
      primary_key :id
      String :slug, :null => false, :unique => true
      Integer :license_id
    end
    add_column :qr_codes, :created_at, 'timestamp with time zone'
  end

  down do
    drop_table(:qr_codes)
  end
end