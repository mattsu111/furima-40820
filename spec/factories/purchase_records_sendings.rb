FactoryBot.define do
  factory :purchase_records_sending do
    postal_code {'123-4567'}
    prefecture_id {2}
    city {'大阪市'}
    address {'塚本1-1'}
    building {'ハイツ102'}
    telephone_number {'00000000000'}
    token {"tok_abcdefghijk00000000000000000"}
  end
end