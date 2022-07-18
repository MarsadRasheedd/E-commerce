# frozen_string_literal: true

class Order < ApplicationRecord
  validates :order_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'format not correct.' }
  validates_numericality_of :amount

  belongs_to :user
end
