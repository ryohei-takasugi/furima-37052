FactoryBot.define do
  factory :item do
    name                   { Faker::Lorem.word }
    info                   { Faker::Lorem.sentence }
    category_id            { Faker::Number.within(range: 1..10) }
    sales_status_id        { Faker::Number.within(range: 1..6) }
    shipping_fee_status_id { Faker::Number.within(range: 1..2) }
    prefecture_id          { Faker::Number.within(range: 1..47) }
    scheduled_delivery_id  { Faker::Number.within(range: 1..3) }
    price                  { Faker::Number.within(range: 300..9999999) }
    association            :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/dog_akitainu.png'), filename: 'dog_akitainu.png')
    end
  end
end
