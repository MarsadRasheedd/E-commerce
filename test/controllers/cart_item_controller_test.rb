# frozen_string_literal: true

require 'test_helper'

class CartItemControllerTest < ActionDispatch::IntegrationTest
  def setup
    @cart = cartts(:one)
    @product = products(:one)
    @cart_item = cart_items(:one)

    @cart_item.cartt_id = @cart.id
    @cart_item.product_id = @product.id

    @user = users(:one)
  end

  test 'should get flash if user is seller' do
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    get cart_items_url
    assert_match(flash[:notice], "Switched to buyer mode.")
    assert_redirected_to root_path
  end

  test 'should get index if user is buyer' do
    @cart = cartts(:one)
    @user.update(role: :buyer)
    @user.cartt_id = @cart.id
    sign_in(@user)

    get cart_items_url
    assert_response :success
  end

  test 'should get index if user is not logged in' do
    @cart_item.cartt_id = @cart.id
    get cart_items_url
    assert_response :success
  end

  test 'should add to cart if user is not logged in' do
    assert_difference('CartItem.count') do
    post cart_items_url,
        params: { cart_item: { quantity: 1, cartt_id: @cart.id, product_id: @product.id } }
    end
    assert_redirected_to root_path
  end

  test 'should add to cart if user is logged in (buyer mode)' do
    @cart = cartts(:one)
    @user.update(role: :buyer)
    @user.cartt_id = @cart.id
    sign_in(@user)

    assert_difference('CartItem.count') do
    post cart_items_url,
        params: { cart_item: { quantity: 1, cartt_id: @user.cartt_id, product_id: @product.id } }
    end
    assert_redirected_to root_path
  end

  test 'should get flash if user is logged in (seller mode)' do
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    post cart_items_url,
        params: { cart_item: { quantity: 1, cartt_id: @user.cartt_id, product_id: @product.id } }

    assert_match(flash[:notice], "You need to switch the mode.")
    assert_redirected_to root_path
  end

  test 'should get flash if product not added to cart' do
    @cart = cartts(:one)
    @user.update(role: :buyer)
    @user.cartt_id = @cart.id
    sign_in(@user)

    post cart_items_url,
        params: { cart_item: { quantity: -1, cartt_id: @user.cartt_id, product_id: @product.id } }

    assert_match(flash[:alert], "Something went wrong while saving.")
    assert_redirected_to root_path
  end

  test 'should update cart item' do
    @cart = cartts(:one)
    @user = users(:one)
    @product = products(:one)

    @cart_item = CartItem.create(quantity: 1, cartt_id: @cart.id, product_id: @product.id )
    patch cart_item_url(@cart_item), params: { id: @cart_item.id, update: {quantity: 2} }
    assert_match(flash[:notice], "Product Updated Successfully.")
    assert_redirected_to cart_items_url
  end

  test 'should get flash if cart item not updated' do
    patch cart_item_url(@cart_item),
        params: { id: @cart_item.id, update: {quantity: 2} }
    assert_match(flash[:alert], "Something went wrong while updating.")
    assert_redirected_to cart_items_url
  end

  test 'should destroy cart item' do
    sign_in(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    assert_difference('CartItem.count', -1) do
      delete cart_item_url(@cart_item)
    end

    assert_match(flash[:notice], "Product removed from cart successfully")
    assert_redirected_to cart_items_url
  end

end
