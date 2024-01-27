class OrdersController < ApplicationController
  def index
    @order_address = OrderAddress.new
  end
  
  def new
    @order_address = OrderAddress.new
  end
  
  def create
    binding.pry
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  private

  def order_params
    params.require(:order_address).permit(:zip_code, :state_province_id, :city_town_village, :street_address, :building_name, :telephone).merge(user_id: current_user.id,item_id:params[:item_id])
  end
end
