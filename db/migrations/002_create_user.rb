Sequel.migration do
  up do
    create_table(:users) do
      primary_key :id
      String :provider
      Integer :uid
      String :name
      String :nickname
      String :email
      String :first_name
      String :last_name
      String :locale
      Integer :tz_offset
      String :oauth_token
      String :oauth_expires_at
      String :image_url
    end
  end

  down do
    drop_table(:users)
  end
end