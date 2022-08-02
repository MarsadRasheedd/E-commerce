# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one)
    @product.serial_no = Product.generate_serial_number
    @product.images.attach(io: File.open('/home/dev/Downloads/watch series 7.jpeg'), filename: 'watch series 7.jpeg')
  end

  test 'product must save on valid attributes' do
    assert(@product.save)
  end

  test 'at least one image must be present' do
    @product.images.attach(io: File.open('/home/dev/Downloads/watch series 7.jpeg'), filename: 'watch series 7.jpeg')
    assert(@product)
  end

  test 'title must be present' do
    @product.title = nil
    assert_not(@product.save)
  end

  test 'title length must be greater than 4' do
    @product.title = 'titl'
    assert_not(@product.save)
  end

  test 'description length must be greater than 4' do
    @product.description = 'desc'
    assert_not(@product.save)
  end

  test 'description must be present' do
    @product.description = nil
    assert_not(@product.save)
  end

  test 'price must be present' do
    @product.price = nil
    assert_not(@product.save)
  end

  test 'price must be a number' do
    @product.price = '1s'
    assert_not(@product.save)
  end

  test 'price must be greater than 10' do
    @product.price = 10
    assert_not(@product.save)
  end

  test 'product must have a unique serial no' do
    serial_nos = []
    11.times do
      serial_nos.append(Product.generate_serial_number)
    end
    serial_no = @product.serial_no
    assert_not_equal(serial_nos.include?(serial_no), true)
  end

  test 'user contains products' do
    @user = users(:one)
    @user.products << @product
    assert_equal(@user.products.include?(@product), true)
  end
end
