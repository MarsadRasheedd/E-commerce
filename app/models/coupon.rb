class Coupon < ApplicationRecord
  scope :is_valid_coupon, -> (promo_code) { where("valid_till > ? and promo_code = ? ", Date.current, promo_code).pluck(:promo_code)}
end
