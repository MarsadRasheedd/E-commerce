# frozen_string_literal: true

class CartItem < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :product
  belongs_to :cartt
end
