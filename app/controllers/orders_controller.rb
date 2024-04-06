class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_public_key, only: [:index, :create]
  before_action :set_item, only: [:index, :create]

  def index
    redirect_to root_path unless current_user.id != @item.user.id && @item.purchase.nil?
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @shipping_purchase = ShippingPurchase.new
  end

  def create
    @shipping_purchase = ShippingPurchase.new(order_params)
    if @shipping_purchase.valid?
      pay_item
      @shipping_purchase.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:shipping_purchase).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
