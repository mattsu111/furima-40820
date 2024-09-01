FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { 'password1' }
    password_confirmation { 'password1' }
    last_name             { '山田' }
    last_name_kana        { 'ヤマダ' }
    first_name            { '太郎' }
    first_name_kana       { 'タロウ' }
    birthday              { '1990-01-01' }
  end
end