# frozen_string_literal: true

# this controller handles pages methods.
class PagesController < ApplicationController
  def show
    @cart_item = CartItem.new
    @products = if params[:search]
                  Product.search(params[:search])
                else
                  Product.all
                end
  end

  def error_page
    render file: 'public/404.html'
  end
end
