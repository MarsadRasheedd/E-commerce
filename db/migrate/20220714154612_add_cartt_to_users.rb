class AddCarttToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :cartt, foreign_key: true
  end
end
