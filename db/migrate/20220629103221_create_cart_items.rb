# frozen_string_literal: true

class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.float :quantity
      t.references :product, foreign_key: true
      t.references :cartt, foreign_key: true

      t.timestamps
    end
  end
end
