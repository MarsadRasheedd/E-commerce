# frozen_string_literal: true

class OrdersList < ApplicationRecord
  validates_numericality_of :quantity, greater_than: 0

  belongs_to :product
  belongs_to :user
end
