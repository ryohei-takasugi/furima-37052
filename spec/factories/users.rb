FactoryBot.define do
  name = Gimei.new
  factory :user do
    email                 { Faker::Internet.email }
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    nickname              { name.last.hiragana }
    last_name             { name.last.kanji }
    last_name_kana        { name.last.katakana }
    first_name            { name.first.kanji }
    first_name_kana       { name.first.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
