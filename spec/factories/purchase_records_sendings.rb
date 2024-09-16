FactoryBot.define do
  factory :purchase_records_sending do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { 'CityName' }
    address { 'AddressName' }
    building { 'BuildingName' }
    telephone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

  end
end