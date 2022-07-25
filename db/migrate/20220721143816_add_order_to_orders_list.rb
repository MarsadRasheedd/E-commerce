class AddOrderToOrdersList < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders_lists, :order, foreign_key: true
  end
end
