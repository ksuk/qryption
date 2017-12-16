class AddIndexLikeItemUnique < ActiveRecord::Migration[5.1]
  def change
    add_index :likes, [:user_id, :item_type, :item_id], unique: true
  end
end
