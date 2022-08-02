# frozen_string_literal: true

require 'test_helper'

class CartItemTest < ActiveSupport::TestCase
  def setup
    @cart_item = cart_items(:one)
  end

  test 'quantity must be present' do
    @cart_item.quantity = nil
    assert_not(@cart_item.save)
  end

  test 'quantity must be number' do
    @cart_item.quantity = '1s'
    assert_not(@cart_item.save)
  end

  test 'quantity must be greater than 0' do
    @cart_item.quantity = 0
    assert_not(@cart_item.save)
  end

  test 'quantity cannot be negative' do
    @cart_item.quantity = -2
    assert_not(@cart_item.save)
  end

  test 'cart items scope must return cart items responding to cart' do
    @product = products(:one)
    @cart = cartts(:one)
    cart_items = []
    @cart_item = CartItem.create(quantity: 1, product_id: @product.id, cartt_id: @cart.id)
    cart_items.append(@cart_item)

    assert_equal(cart_items, CartItem.cart_items(@cart.id))
  end

  test 'cart item belongs to product' do
    @product = products(:one)
    @cart_item.product_id = @product.id
    assert_equal(@product.id, @cart_item.product_id)
  end

  test 'cart item belongs to cart' do
    @cart = cartts(:one)
    @cart_item.cartt_id = @cart.id
    assert_equal(@cart.id, @cart_item.cartt_id)
  end
end
