class UpdateOrderItemIndex < ActiveRecord::Migration
  def up
    remove_index :order_items, name: 'index_order_items_on_order_id_and_item_id'
    add_index :order_items, [:order_id, :order_type, :item_id], unique: true
  end

  def down
    remove_index :order_items, name: 'index_order_items_on_order_id_and_order_type_and_item_id'
    add_index :order_items, [:order_id, :item_id], unique: true
  end
end
