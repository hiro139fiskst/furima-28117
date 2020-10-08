class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def move_to_index
    redirect_to new_user_session_path unless user_signed_in?
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

  def index
    @items = Item.includes(:user).order('created_at ASC')
  end

  private

  def item_params
    params.require(:item).permit(:image, :user, :name, :description, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :handling_time_id, :price).merge(user_id: current_user.id)
  end
end
