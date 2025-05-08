class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
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

  # def edit
  # end

  # def update
  # end

  # def destroy
  # end

  private

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
