FactoryBot.define do
  factory :user do
    nickname {Faker::Name.first_name}
    email {Faker::Internet.email}
    password {"abc123"}
    password_confirmation { password }
    last_name {"テスト山"}
    first_name {"テスト郎"}
    last_name_kana {"テストヤマ"}
    first_name_kana {"テストロー"}
    birthday_on {Faker::Date.birthday}
  end
end