# frozen_string_literal: true

# this controller handles pages methods.
class PagesController < ApplicationController
  def show
    @cart_item = CartItem.new
    @products = params[:search] ? Product.search(params[:search]) : Product.all
  end

  def error_page
    render file: 'public/404.html'
  end
end
