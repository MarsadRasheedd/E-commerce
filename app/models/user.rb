class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_one :shopping_cart
  has_one :cart
  has_one :cartt

  has_many :cart_lists
  has_many :products, through: :cart_lists

  enum role: {visitor: 0,seller: 1,buyer: 2}

end
