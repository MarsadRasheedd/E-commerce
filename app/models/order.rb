# frozen_string_literal: true

class Order < ApplicationRecord
  validates :order_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'format not correct.' }
  validates :amount, numericality: true

  belongs_to :user
  has_many :orders_lists, dependent: :destroy
end
