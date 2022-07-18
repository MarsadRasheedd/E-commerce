# frozen_string_literal: true

class Coupon < ApplicationRecord
  validates :promo_code, presence: true,
                         format: { with: /\A[A-Z0-9]+.[0-9]+.{1}[0-9]*{4,10}\z/, message: 'format not correct.' }
  validates :valid_till, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/, message: 'date format not correct.' }

  scope :is_valid_coupon, lambda { |promo_code|
                            where('valid_till > ? and promo_code = ? ', Date.current, promo_code).pluck(:promo_code)
                          }
end
