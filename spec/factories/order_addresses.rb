FactoryBot.define do
  factory :order_address do
    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item).id }
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '東京都' }
    address { '渋谷1-1-1' }
    building { '渋谷ハイツ' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

    initialize_with { new(attributes) }
  end
end
