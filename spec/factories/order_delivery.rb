FactoryBot.define do
  address = Gimei.new
  factory :order_delivery do
    token         { Faker::Lorem.characters(number: 32, min_alpha: 1, min_numeric: 1) }
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.within(range: 1..47) }
    city          { address.city.kanji }
    addresses     { address.town.kanji }
    building      { Faker::Address.building_number }
    phone_number  { Faker::Number.number(digits: 11) }
  end
end
