FactoryGirl.define do
  to_create { |instance| instance.save }

  factory :user do
    name 'Schmob Schmriski'
    email 'schmob@example.com'
  end

  factory :license do
    number '7SDF234'
    slug 'ew23'
  end

  factory :status do
    status 'CHARGING'
    description 'Will be back at 11PM'
  end

  factory :qr_code, :class => QRCode do
    slug '4fed'
  end
end