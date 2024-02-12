FactoryBot.define do
  factory :order_shipping_address do
    postal_code { '123-4567' }
    prefecture_id { '2' }
    city { '函館市' }
    addresses { '12-34' }
    building { 'ハイツ２号' }
    phone_number { 1_234_567_890 }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
