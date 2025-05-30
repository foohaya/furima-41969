require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:item) { FactoryBot.create(:item) }
  let(:order_address) do
    OrderAddress.new(
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '渋谷区',
      address: '渋谷1-1-1',
      building: '渋谷ハイツ',
      phone_number: '09012345678',
      token: 'tok_abcdefghijk00000000000000000',
      user_id: user.id,
      item_id: item.id
    )
  end

  context 'クレジットカード情報' do
    it 'tokenがあれば決済できる（保存できる）' do
      expect(order_address).to be_valid
    end

    it 'tokenが空では保存できない' do
      order_address.token = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Token can't be blank")
    end
  end

  context '内容に問題がない場合' do
    it 'すべての値が正しく入力されていれば保存できる' do
      expect(order_address).to be_valid
    end

    it '建物名が空でも保存できる' do
      order_address.building = ''
      expect(order_address).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号が空では保存できない' do
      order_address.postal_code = ''
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号がハイフンなしでは保存できない' do
      order_address.postal_code = '1234567'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    it '都道府県が1（---）では保存できない' do
      order_address.prefecture_id = 1
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Prefecture must be other than 1')
    end

    it '市区町村が空では保存できない' do
      order_address.city = ''
      order_address.valid?
      expect(order_address.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では保存できない' do
      order_address.address = ''
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空では保存できない' do
      order_address.phone_number = ''
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁以下では保存できない' do
      order_address.phone_number = '090123456'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が12桁以上では保存できない' do
      order_address.phone_number = '090123456789'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it '電話番号が半角数字以外では保存できない' do
      order_address.phone_number = '090-1234-5678'
      order_address.valid?
      expect(order_address.errors.full_messages).to include('Phone number is invalid')
    end

    it 'tokenが空では登録できない' do
      order_address.token = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_idが空では保存できない' do
      order_address.user_id = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idが空では保存できない' do
      order_address.item_id = nil
      order_address.valid?
      expect(order_address.errors.full_messages).to include("Item can't be blank")
    end
  end
end
