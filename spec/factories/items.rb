FactoryBot.define do
  factory :item do
    name                   { 'テスト商品' }
    info                   { 'テスト説明文' }
    category_id            { 2 }
    sales_status_id        { 2 }
    shipping_fee_id        { 2 }
    prefecture_id          { 2 }
    scheduled_delivery_id  { 2 }
    price                  { 1000 }

    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
