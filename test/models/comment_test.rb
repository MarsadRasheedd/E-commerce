# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test 'comment must be present' do
    @comment.comment = nil
    assert_not(@comment.save)
  end

  test 'comment must belong to product' do
    @product = products(:one)
    @comment.product_id = @product.id
    assert_equal(@product.id, @comment.product_id)
  end

  test 'comment must belong to user' do
    @user = users(:one)
    @comment.user_id = @user.id
    assert_equal(@user.id, @comment.user_id)
  end
end
