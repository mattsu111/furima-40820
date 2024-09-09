class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:edit, :show, ]
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end
  def new
    @item = Item.new
  end
def create
  @item = Item.new(item_params)
  @item.user = current_user

  if @item.save
    redirect_to root_path, notice: 'Item was successfully created.'
  else
    render :new, status: :unprocessable_entity
  end

  def show

  end


end
  private
  
  def item_params
    params.require(:item).permit(:image, :item_name, :price, :explanation, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :ship_date_id).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end  


end