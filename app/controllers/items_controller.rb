class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params)
    puts "item_params[:price]: #{item_params[:price]}"
    puts "item.price         : #{item.price}"
    if item.valid? && item.save
      redirect_to root_path
    else
      @item = item
      render :new
    end
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end
end
