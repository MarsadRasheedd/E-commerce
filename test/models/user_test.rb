# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @cart = cartts(:one)
    @user = users(:one)
  end

  test 'user saved on valid attributes' do
    assert(@user)
  end

  test 'first name must be present' do
    @user.first_name = nil
    assert_not(@user.save)
  end

  test 'first name length must be greater than 3' do
    @user.first_name = 'abc'
    assert_not(@user.save)
  end

  test 'last name must be present' do
    @user.last_name = nil
    assert_not(@user.save)
  end

  test 'last name length must be greater than 3' do
    @user.last_name = 'abc'
    assert_not(@user.save)
  end

  test 'email must be present' do
    @user.email = nil
    assert_not(@user.save)
  end

  test 'email length must be greater than 3' do
    @user.email = 'abc'
    assert_not(@user.save)
  end

  test 'email format must be present' do
    @user.email = 'abcgmail.com'
    assert_not(@user.save)
  end

  test 'phone must be present' do
    @user.phone = nil
    assert_not(@user.save)
  end

  test 'phone length must be greater than 7' do
    @user.phone = 1_234_567
    assert_not(@user.save)
  end

  test 'phone must be integer' do
    @user.phone = '1234567'
    assert_not(@user.save)
  end

  test 'address must be present' do
    @user.address = nil
    assert_not(@user.save)
  end

  test 'address length must be greater than 7' do
    @user.phone = 'gujran'
    assert_not(@user.save)
  end

  test 'password must be present' do
    @user.password = nil
    assert_not(@user.save)
  end

  test 'cart id must be present' do
    @user.cartt_id = nil
    assert_not(@user.save)
  end

  test 'user belongs to cart' do
    @user.cartt_id = @cart.id
    assert_equal(@user.cartt_id, @cart.id)
  end

  test 'default user role is buyer' do
    assert(@user.buyer?)
  end

  test 'user role must be updated on update' do
    @user.update(role: :seller)
    assert(@user.seller?)
  end
end
