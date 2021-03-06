class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :sold_out, only: [:index, :create]
  before_action :topindex
  before_action :item_find, only: [:index, :create, :pay_item]

  require 'payjp'



  def index

    @item_purchase = ItemPurchase.new
  end

  def create

    @item_purchase = ItemPurchase.new(order_params)
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.permit(:item_id, :post_code, :prefecture_id, :city, :address_number, :building_name, :phone_number, :price, :token).merge(user_id: current_user.id)
  end

  def pay_item
 
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def sold_out
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.purchase.present?
  end
end

def item_find
  @item = Item.find(params[:item_id])
end

  def topindex
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end
