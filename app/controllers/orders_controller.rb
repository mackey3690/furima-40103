class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_public_key, only: [:index, :create]
 

  def index
    @item = Item.find(params[:item_id])
    redirect_to root_path unless current_user.id != @item.user.id && @item.purchase.nil?
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @shipping_purchase = ShippingPurchase.new
  end

  def create
    @item = Item.find(params[:item_id])
    @shipping_purchase = ShippingPurchase.new(order_params)
    if @shipping_purchase.valid?
      pay_item
      @shipping_purchase.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render "index", status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:shipping_purchase).permit(:postal_code, :prefecture, :city, :addresses, :building, :phone_number)
    .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

 

end
