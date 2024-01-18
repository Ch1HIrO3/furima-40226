class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :nickname, presence: true
  validates :email, presence: true
  validates :encrypted_password, presence: true, format: {with: /\A[a-z0-9]+\z/i, message: "is invalid. Input half-width characters."}
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birthday, presence: true
end