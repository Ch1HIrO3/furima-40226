class Address < ApplicationRecord
  belongs_to :order
  validates :zip_code, :state_province_id, :city_town_village, :street_address, :telephone, presence: true
end
