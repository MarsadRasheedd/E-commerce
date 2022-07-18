# frozen_string_literal: true

class Cartt < ApplicationRecord
  has_one :user
  has_many :cart_items
end
