class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :item_set
  before_action :move_to_root

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    redirect_to root_path if user_signed_in? && current_user.id == @item.user_id
    @order_shipping_address = OrderShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
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

  def item_params
    params.require(:item).permit(:item_name, :item_info, :item_category_id, :item_sales_status_id, :item_shipping_fee_status_id, :prefecture_id,
                                 :item_scheduled_delivery_id, :item_price, :image).merge(user_id: current_user.id)
  end

  def order_params
    params.require(:order_shipping_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def item_set
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = 'sk_test_0191ea891ee5a973aab0290d'
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
