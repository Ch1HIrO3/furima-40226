class OrdersController < ApplicationController
  before_action :set_item,only:[:index,:create]
  before_action :authenticate_user!

  def index
    @order_address = OrderAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if user_can_not_purchase?
      redirect_to root_path
    end
  end
  
  def new
    @order_address = OrderAddress.new
  end
  
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end
  private
  
  def order_params
    params.require(:order_address).permit(
      :zip_code,
      :state_province_id,
      :city_town_village,
      :street_address,
      :building_name,
      :telephone
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def user_can_not_purchase?
    @item.user == current_user || @item.order != nil
  end
end
