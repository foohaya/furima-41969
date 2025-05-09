class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_seller, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @item = Item.new
    set_collections
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to root_path
    else
      set_collections
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_collections
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      set_collections
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: '商品を削除しました'
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_seller
    redirect_to root_path unless current_user == @item.user
  end

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image)
  end

  def set_collections
    @categories = Category.all
    @sales_statuses = SalesStatus.all
    @shipping_fees = ShippingFee.all
    @prefectures = Prefecture.all
    @scheduled_deliveries = ScheduledDelivery.all
  end
end
