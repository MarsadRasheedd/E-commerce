# frozen_string_literal: true

class CartItem < ApplicationRecord
  validates_numericality_of :quantity, greater_than: 0

  belongs_to :product
  belongs_to :cartt
end
