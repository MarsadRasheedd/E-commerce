# frozen_string_literal: true

class OrdersList < ApplicationRecord
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :product
  belongs_to :user
end
