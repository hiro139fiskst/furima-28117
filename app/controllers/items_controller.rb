class ItemsController < ApplicationController
  # skip_before_action :authenticate_user!  ,only: [:show, :index]
  before_action :item_set, only: [:edit, :show, :update]
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

  def edit
  end

  def show
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render show
    end
  end

  def update
    if @item.update(item_params)
        redirect_to item_path
    else
      render :edit
    end
  end

  def index
    @items = Item.includes(:user).order('created_at ASC')
  end

  private

  def item_params
    params.require(:item).permit(:image, :user, :name, :description, :category_id, :condition_id, :postage_payer_id, :prefecture_id, :handling_time_id, :price).merge(user_id: current_user.id)
  end

  def item_set
    @item = Item.find(params[:id])
  end

end
