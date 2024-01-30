class OrderAddress
  include ActiveModel::Model
  attr_accessor(
  :zip_code,
  :state_province_id,
  :city_town_village,
  :street_address,
  :building_name,
  :telephone,
  :item_id,
  :user_id,
  :token
)
  with_options presence: true do
    validates :state_province_id, :city_town_village, :street_address, :user_id, :item_id, :token
    validates :state_province_id,numericality: { other_than: 1 }
    validates :zip_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :telephone, numericality: {with: /\A[0-9]{10}\z/}, length: { minimum: 10,maximum: 11 }
  end

  def save
    order = Order.create(user_id: user_id, item_id:item_id)
    Address.create(
      zip_code: zip_code,
      state_province_id: state_province_id,
      city_town_village: city_town_village,
      street_address: street_address,
      building_name: building_name,
      telephone: telephone,
      order_id: order.id
    )
  end
end