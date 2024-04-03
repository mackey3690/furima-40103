FactoryBot.define do
  factory :shipping_purchase do
    postal_code { '123-4567' }
    prefecture { 1 }
    city { '東京都' }
    addresses { '1-1' }
    building { '東京ハイツ' }
    phone_number { '02036548569' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
