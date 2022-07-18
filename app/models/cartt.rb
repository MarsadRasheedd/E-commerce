# frozen_string_literal: true

class Cartt < ApplicationRecord
  has_one :user, dependent: :destroy
  has_many :cart_items, dependent: :destroy
end
