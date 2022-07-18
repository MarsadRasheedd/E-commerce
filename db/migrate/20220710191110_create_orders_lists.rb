# frozen_string_literal: true

class CreateOrdersLists < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_lists do |t|
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.float :quantity

      t.timestamps
    end
  end
end
