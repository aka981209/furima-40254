class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_set
  before_action :move_to_root

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']

    redirect_to root_path if user_signed_in? && current_user.id == @item.user_id
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_shipping_address = OrderShippingAddress.new(order_params)

    if @order_shipping_address.valid?
      pay_item
      @order_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private


  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def item_set
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(params[:item_id]).item_price, # 商品の値段
      card: order_params[:token], # カードト ークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def move_to_root
    return unless @item.user_id == current_user.id || !@item.order.nil?

    redirect_to root_path
  end
end
