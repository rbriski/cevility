Sequel.migration do
  up do
    alter_table(:users) do
      set_column_type :uid, 'int8'
    end
  end

  down do
    alter_table(:users) do
      set_column_type :uid, Integer
    end
  end
end