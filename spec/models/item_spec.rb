require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '出品できるとき' do
    it '全ての項目が正しく入力されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '出品できないとき' do
    it '画像がないと出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空では出品できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it 'カテゴリーが---では出品できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it '価格が299円以下では出品できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end

    it '価格が10_000_000円以上では出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end

    it '価格が全角では登録できない' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end
  end
end
