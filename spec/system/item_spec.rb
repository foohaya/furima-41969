require 'rails_helper'

RSpec.describe '商品出品', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインしている場合' do
    it '正しい情報を入力すれば出品できてトップページへ遷移する' do
      sign_in @user

      visit new_item_path

      attach_file 'item[image]', Rails.root.join('spec/fixtures/files/test_image.png'), make_visible: true
      fill_in 'item[name]', with: 'テスト商品'
      fill_in 'item[description]', with: '商品の説明です'
      select 'メンズ', from: 'item[category_id]'
      select '新品・未使用', from: 'item[condition_id]'
      select '送料込み(出品者負担)', from: 'item[shipping_fee_id]'
      select '東京都', from: 'item[prefecture_id]'
      select '1~2日で発送', from: 'item[shipping_day_id]'
      fill_in 'item[price]', with: 5000

      click_button '出品する'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('テスト商品')
    end

    context '販売価格を入力した場合' do
      it '販売手数料と販売利益が正しく表示される', js: true do
        sign_in @user
        visit new_item_path

        fill_in 'item[price]', with: 1000

        expect(page).to have_content('販売手数料：¥100')
        expect(page).to have_content('販売利益：¥900')
      end
    end
  end
end
