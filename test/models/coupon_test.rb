# frozen_string_literal: true

require 'test_helper'

class CouponTest < ActiveSupport::TestCase
  def setup
    @coupon = coupons(:one)
  end

  test 'promo code must present' do
    @coupon.promo_code = nil
    assert_not(@coupon.save)
  end

  test 'promo code must contains capital characters' do
    @coupon.promo_code = 'dev:0.5'
    assert_not(@coupon.save)
  end

  test 'promo code length must be greater than 4' do
    @coupon.promo_code = 'DEV'
    assert_not(@coupon.save)
  end

  test 'promo code length must be less than 10' do
    @coupon.promo_code = 'DEVSINC:0.23'
    assert_not(@coupon.save)
  end

  test 'promo code must conatin special character' do
    @coupon.promo_code = 'DEVSINC02.333'
    assert_not(@coupon.save)
  end

  test 'coupon must save on valid promo code' do
    @coupon.promo_code = 'DEV:0.5'
    assert_not(@coupon.save)
  end

  test 'valid till date must be present' do
    @coupon.valid_till = nil
    assert_not(@coupon.save)
  end

  test 'valid till date format must be yyyy-mm-dd' do
    @coupon.valid_till = '21-12-2024'
    assert_not(@coupon.save)
  end

  test 'valid till date format must contains - between date' do
    @coupon.valid_till = '2023/12-12'
    assert_not(@coupon.save)
  end
end
