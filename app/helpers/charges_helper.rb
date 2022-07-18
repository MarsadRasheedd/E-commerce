# frozen_string_literal: true

# Helper class for charges
module ChargesHelper
  def create_order
    current_user.update(role: :buyer)
    order = Order.new(user_id: current_user.id, order_date: Date.current, amount: amount)
    order.save

    set_up_order_list
  end

  def set_up_order_list
    user_cart = Cartt.find(current_user.cartt_id)
    cart_items = CartItem.select('*').where(cartt_id: user_cart.id)

    cart_items.each do |item|
      OrdersList.create(product_id: item.product_id, user_id: current_user.id, quantity: item.quantity)
    end
  end
end
