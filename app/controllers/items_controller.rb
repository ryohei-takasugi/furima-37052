class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_item_find, only: [:show, :edit, :update, :destroy]
  before_action :confirm_identity, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  def load_item_find
    @item = Item.find(params[:id])
  end

  def confirm_identity
    redirect_to root_path unless current_user.id == @item.user_id
  end
end
