class PagesController < ApplicationController
  def show
    @cart_item = CartItem.new

    @products = Product.all
  end
end
