Sequel.migration do
  up do
    add_column :statuses, :license_id, Integer, :null => false
    drop_column :statuses, :license
  end

  down do
    add_column :statuses, :license, Integer, :null => false
    drop_column :statuses, :license_id
  end
end