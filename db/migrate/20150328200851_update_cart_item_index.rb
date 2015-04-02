class UpdateCartItemIndex < ActiveRecord::Migration
  def up
    remove_index :cart_items, name: 'index_cart_items_on_cart_id_and_item_id'
    add_index :cart_items, [:cart_id, :cart_type, :item_id], unique: true
  end

  def down
    remove_index :cart_items, name: 'index_cart_items_on_cart_id_and_cart_type_and_item_id'
    add_index :cart_items, [:cart_id, :item_id], unique: true
  end
end
