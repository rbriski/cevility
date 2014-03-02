Sequel.migration do
  up do
    create_table(:licenses) do
      primary_key :id
      Integer :user_id
      String :number
      String :slug
    end
    add_column :licenses, :created_at, 'timestamp with time zone'
    add_column :licenses, :updated_at, 'timestamp with time zone'
    add_index :licenses, :user_id
    add_index :licenses, :slug
    add_index :licenses, :number
  end

  down do
    drop_table(:licenses)
  end
end