# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:one)
  end

  test 'date must be present' do
    @order.order_date = nil
    assert_not(@order.save)
  end

  test 'amount must be present' do
    @order.amount = nil
    assert_not(@order.save)
  end

  test 'amount must be integer' do
    @order.amount = '12$'
    assert_not(@order.save)
  end

  test 'order format must be yyyy-mm-dd' do
    @order.order_date = '21-12-2024'
    assert_not(@order.save)
  end

  test 'order format must contains - between date' do
    @order.order_date = '2023/12-12'
    assert_not(@order.save)
  end

  test 'order must belong to user who is making an order' do
    @user = users(:one)
    @order.user_id = @user.id
    assert_equal(@user.id, @order.user_id)
  end

  test 'order must belong to user' do
    @order.user_id = nil
    assert_not(@order.save)
  end

  test 'DEV:0.5 must be returned by is_valid_coupon scope' do
    assert_equal('DEV:0.5', Coupon.is_valid_coupon('DEV:0.5')[0])
  end

  test 'Coupon with date: 2021-12-12, promo: PAK:0.5 must not be returned by is_valid_coupon scope' do
    Coupon.create(promo_code: 'PAK:0.5', valid_till: '2021-12-12')
    assert_not_equal('PAK:0.5', Coupon.is_valid_coupon('DEV:0.5'))
  end
end
