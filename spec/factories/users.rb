FactoryBot.define do
  factory :user do
    nickname              { 'テストユーザー' }
    email                 { Faker::Internet.unique.email }
    password              { 'abc123' }
    password_confirmation { password }
    last_name             { '山田' }
    first_name            { '太郎' }
    last_name_kana        { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    birthday              { Faker::Date.birthday(min_age: 6, max_age: 90) }
  end
end