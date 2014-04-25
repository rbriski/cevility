Sequel.migration do
  up do
    add_index(
      :licenses,
      [:user_id, :number],
      :unique => true,
      :name => :licenses_user_id_number_idx
    )
  end

  down do
    remove_index :licenses, :name => :licenses_user_id_number_idx
  end
end