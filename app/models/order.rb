class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  validates :name, :description,:image, presence: true
end
