require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
  end

  def basic_auth(user, pass)
    credentials = ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
    { 'HTTP_AUTHORIZATION' => credentials }
  end

  context 'ログインしていないユーザー' do
    it '購入ページにアクセスするとログインページにリダイレクトされる' do
      get item_orders_path(@item), headers: basic_auth('admin', '2222')
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'ログインしているユーザー' do
    before do
      sign_in @user
    end

    it '自身が出品していない商品の購入ページにはアクセスできる' do
      get item_orders_path(@item), headers: basic_auth('admin', '2222')
      expect(response).to have_http_status(:ok)
    end

    it '自身が出品した商品の購入ページにアクセスするとトップページにリダイレクトされる' do
      own_item = FactoryBot.create(:item, user: @user)
      get item_orders_path(own_item), headers: basic_auth('admin', '2222')
      expect(response).to redirect_to(root_path)
    end
  end
end
