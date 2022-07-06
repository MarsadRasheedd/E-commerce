class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_one :cartt
  has_and_belongs_to_many :products

  enum role: {visitor: 0,seller: 1,buyer: 2}

end
