Sequel.migration do
  up do
    alter_table(:users) do
      add_column :created_at, 'timestamp with time zone'
      add_column :updated_at, 'timestamp with time zone'
    end
  end

  down do
    alter_table(:users) do
      drop_column :created_at
      drop_column :updated_at
    end
  end
end