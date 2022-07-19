# frozen_string_literal: true

class CartItem < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }
  scope :cart_items, lambda { |cartt_id|
                       CartItem.select('*').where(cartt_id: cartt_id)
                     }
  belongs_to :product
  belongs_to :cartt
end
