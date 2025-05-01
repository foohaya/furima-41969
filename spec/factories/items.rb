FactoryBot.define do
  factory :item do
    name                   { 'テスト商品' }
    info                   { 'テスト説明文' }
    category_id            { 2 } # 1は---なので、2以降を選択
    sales_status_id        { 2 }
    shipping_fee_id        { 2 }
    prefecture_id          { 2 }
    scheduled_delivery_id  { 2 }
    price                  { 1000 }

    association :user

    # ActiveStorage用に画像も用意
    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')),
        filename: 'test_image.png',
        content_type: 'image/png'
      )
    end
  end
end
