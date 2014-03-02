FactoryGirl.define do
  factory :user do
    :name 'Schmob Schmriski'
    :email 'schmob@example.com'
  end

  factory :license do
    :license '7SDF234'
    :slug 'ew23'
    user
  end
end