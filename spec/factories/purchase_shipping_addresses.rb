FactoryBot.define do
  factory :purchase_shipping_address do
    post_code {"123-1234"}
    prefecture_id {2}
    address {"呉市浜松町"}
    house_number {"13-2"}
    building {"テスト荘302号室"}
    tel {"09012345678"}
    token {"00000000000000000"}

  end
end
