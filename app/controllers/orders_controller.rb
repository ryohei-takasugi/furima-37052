class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_item_find
  before_action :confirm_identity
  before_action :confirm_sould_out

  def index
    @order_delivery = OrderDelivery.new
  end

  def create
    @order_delivery = OrderDelivery.new(order_params)
    if @order_delivery.valid?
      pay_item
      @order_delivery.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_delivery).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(token: params[:token], item_id: params[:item_id], user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def load_item_find
    @item = Item.find(params[:item_id])
  end

  def confirm_identity
    redirect_to root_path if current_user.id == @item.user_id
  end

  def confirm_sould_out
    redirect_to root_path if Order.exists?(item_id: params[:item_id])
  end
end
