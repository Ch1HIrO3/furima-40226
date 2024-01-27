class OrdersController < ApplicationController
  before_action :set_item,only:[:index,:create]

  def index
    @order_address = OrderAddress.new
  end
  
  def new
    @order_address = OrderAddress.new
  end
  
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
  private
  
  def order_params
    params.require(:order_address).permit(:zip_code, :state_province_id, :city_town_village, :street_address, :building_name, :telephone).merge(user_id: current_user.id,item_id:params[:item_id])
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end
end
