# frozen_string_literal: true

# this controller handles cart items methods.
class CartItemsController < ApplicationController
  def index
    if current_user
      config_buyer if !current_user.buyer?
      @cart_items = CartItem.cart_items(current_user.cartt_id)
    else
      cart_id = session['cart_id']
      @cart_items = CartItem.cart_items(cart_id)
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if !current_user&.buyer?
      flash[:notice] = "You need to switch the mode."
    elsif @cart_item.save
      flash[:notice] = 'Product added to cart successfully..'
    else
      flash[:alert] = 'Something went wrong while saving.'
    end

    redirect_to :root
  end

  def increment_quantity
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(quantity: (@cart_item.quantity + 1))
      flash[:notice] = 'Product Updated Successfully.'
    else
      flash[:alert] = 'Something went wrong while updating.'
    end
    redirect_to :cart_items
  end

  def decrement_quantity
    @cart_item = CartItem.find(params[:id])
    return unless @cart_item.quantity != 1

    if @cart_item.update(quantity: (@cart_item.quantity - 1))
      flash[:notice] = 'Product Updated Successfully.'
    else
      flash[:alert] = 'Something went wrong while updating.'
    end
    redirect_to :cart_items
  end

  def delete_item
    @cart_item = CartItem.find(params[:id])
    if @cart_item.destroy
      flash[:notice] = 'Product removed from cart successfully'
    else
      flash[:alert] = 'Something went wrong while deleting.'
    end
    redirect_to :cart_items
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cartt_id)
  end

  def config_buyer
    current_user.update(role: :buyer)
    flash[:notice] = 'Switched to buyer mode.'
    redirect_to :root
  end
end
