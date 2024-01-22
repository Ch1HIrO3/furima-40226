class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :state_province
  belongs_to :days_to_ship
  has_one_attached :image

  validates :name, :description, :user_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  validates :category_id, :condition_id, :shipping_charge_id, :state_province_id, :days_to_ship_id, numericality: { other_than: 1 }
end
