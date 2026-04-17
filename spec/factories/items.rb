FactoryBot.define do
  factory :item do
    name {Faker::Commerce.product_name}
    price {1000}
    description {Faker::Lorem.sentence}
    category_id {2}
    condition_id {2}
    shipping_fee_id {2}
    prefecture_id {2}
    shipping_time_id {2}

    association :user
 

    after(:build) do |item|
      item.image.attach(io: File.open('public/test.jpg'), filename: 'test.jpg')
    end
  end
end
