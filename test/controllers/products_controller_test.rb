# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @product = products(:one)
    @user = users(:one)
  end

  test 'should get index' do
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    get products_url
    assert_response :success
  end

  test 'should get public products' do
    get public_products_products_url
    assert_response :success
  end

  test 'should search products if params found' do
    assert('Product') do
      post products_url,
        params: { search: "product" }
    end
  end

  test 'should get error page' do
    get '/no_defined_route'
    assert_response :missing
  end

  test 'should get flash on getting index if user is buyer' do
    @cart = cartts(:one)
    @user.update(role: :buyer)
    @user.cartt_id = @cart.id

    sign_in(@user)
    get products_url
    assert_match(flash[:notice], "Switched to seller")
    assert_redirected_to root_path
  end

  test 'should get new' do
    sign_out(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    get new_product_url
    assert_response :success
  end

  test 'should create product' do

    sign_out(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    file = fixture_file_upload(Rails.root.join('/home/dev/Downloads', 'footabll.jpeg'), 'image/jpeg')

    assert_difference('Product.count') do
      post products_url,
           params: { product: { description: @product.description, price: @product.price,
                                title: @product.title, images: [file]
                                 } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should not create product if param is nil' do

    sign_out(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    file = fixture_file_upload(Rails.root.join('/home/dev/Downloads', 'footabll.jpeg'), 'image/jpeg')

    assert_no_difference('Product.count') do
      post products_url,
           params: { product: { description: @product.description, price: nil,
                                title: @product.title, images: [file]
                                 } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show product' do
    sign_out(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    sign_in(@user)

    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    sign_in(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    sign_in(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    file = fixture_file_upload(Rails.root.join('/home/dev/Downloads', 'footabll.jpeg'), 'image/jpeg')

    patch product_url(@product),
          params: { product: { description: @product.description, price: @product.price, serial_no: Product.generate_serial_number,
                               title: @product.title, images: [file] } }
    assert_redirected_to product_url(@product)
  end

  test 'should not update product if product is nil' do
    sign_in(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    patch product_url(@product),
          params: { product: { description: @product.description, price: @product.price, serial_no: Product.generate_serial_number,
                               title: @product.title, images: nil} }
    assert_response :unprocessable_entity
  end

  test 'should not destroy product if user is not owner' do
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    @second = users(:two)
    sign_in(@second)

    delete product_url(@product)
    assert_response :redirect
    assert_redirected_to root_url
  end

  test 'should not edit product if user is not owner' do
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    @second = users(:two)
    sign_in(@second)

    get edit_product_url(@product)
    assert_response :redirect
    assert_redirected_to root_url
  end

  test 'should destroy product' do
    sign_in(@user)
    @cart = cartts(:one)
    @user.update(role: :seller)
    @user.cartt_id = @cart.id
    @user.products << @product

    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
