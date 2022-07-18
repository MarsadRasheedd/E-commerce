# frozen_string_literal: true

class CreateCartts < ActiveRecord::Migration[5.2]
  def change
    create_table :cartts do |t|
      t.float :totalPrice
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
