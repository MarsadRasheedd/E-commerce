class RemoveUserIdFromCartt < ActiveRecord::Migration[5.2]
  def change
    remove_column :cartts, :user_id, :bigint
  end
end
