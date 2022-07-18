# frozen_string_literal: true

class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.string :promo_code
      t.date :valid_till

      t.timestamps
    end
  end
end
