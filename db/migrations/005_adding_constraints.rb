Sequel.migration do
  # Add not nulls to user and license columns
  up do
    alter_table(:users) do
      set_column_not_null :email
      set_column_not_null :name
    end
    alter_table(:licenses) do
      set_column_not_null :number
    end
  end

  down do
    alter_table(:users) do
      set_column_allow_null :email
      set_column_allow_null :name
    end
    alter_table(:licenses) do
      set_column_allow_null :number
    end
  end
end