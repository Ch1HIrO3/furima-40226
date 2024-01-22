class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_charge
  belongs_to :state_province
  belongs_to :days_to_ship

  validates :name, :description, :price, :user_id, presence: true
  validates :category_id, :condition_id, :shipping_charge_id, :state_province_id, :days_to_ship_id, numericality: { other_than: 1 }
end