class CartItemsController < ApplicationController

  def index
    @cartt = Cartt.find_by(user_id: current_user.id)
    @cart_items = CartItem.select("*").where(cartt_id: @cartt.id)
  end


  def create
    @cartItem = CartItem.new(cart_item_params)
    if @cartItem.save
      flash[:notice] = "Product added to cart successfully.."
    else
      flash[:alert] = "Something went wrong while saving."
    end
    redirect_to :root
  end

  def increment_quantity_item
    @cartItem = CartItem.find(params[:id])
    if @cartItem.update(quantity: (@cartItem.quantity + 1))
      flash[:notice] = "Product Updated Successfully."
    else
      flash[:alert] = "Something went wrong while updating."
    end
    redirect_to :cart_items
  end

  def decrement_quantity_item
    @cartItem = CartItem.find(params[:id])
    if @cartItem.quantity != 1
      if @cartItem.update(quantity: (@cartItem.quantity - 1))
        flash[:notice] = "Product Updated Successfully."
      else
        flash[:alert] = "Something went wrong while updating."
      end
      redirect_to :cart_items
    else
      flash[:notice] = "Product quanity cannot be less than 1."
    end
  end

  def update_item
    @cartItem = CartItem.find(params[:id])
    @cartItem.update(cart_item_params)
  end

  def delete_item
    @cartItem = CartItem.find(params[:id])
    if @cartItem.destroy
      flash[:notice] = "Product removed from cart successfully"
    else
      flash[:alert] = "Something went wrong while deleting."
    end
    redirect_to :cart_items
  end


  def update
    @cartItem = CartItem.find(params[:id])
    @cartItem.update_attributes(cart_params)
  end

  def destroy
    # @cart_item = CartItem.find(params[:id])
    # @cart_item.destroy
    # respond_to do |format|
    #     format.html { redirect_to :root notice: 'Article was successfully deleted.' }
    #     format.json { head :no_content }
    # end

    # @cart_item = CartItem.find_by(cart_item_params)
    # if @cartItem.destroy
    #   flash[:notice] = "Product removed from cart successfully.."
    # else
    #   flash[:alert] = "Something went wrong!"
    # end
    # redirect_to :root
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id, :cartt_id)
  end

end
