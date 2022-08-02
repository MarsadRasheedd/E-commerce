# frozen_string_literal: true

require 'test_helper'

class OrdersListTest < ActiveSupport::TestCase
  def setup
    @orders = orders_lists(:one)
  end

  test 'quantity must be integer' do
    @orders.quantity = '10$'
    assert_not(@orders.save)
  end

  test 'quantity must be greater than 0' do
    @orders.quantity = 1
    assert(@orders)
  end

  test 'quantity must be not 0' do
    @orders.quantity = 0
    assert_not(@orders.save)
  end

  test 'quantity must not be negative' do
    @orders.quantity = -2
    assert_not(@orders.save)
  end
end
