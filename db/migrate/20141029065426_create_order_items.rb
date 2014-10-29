class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.money :price
      t.integer :quantity

      t.timestamps
    end
    add_index :order_items, :order_id
    add_index :order_items, :item_id
    add_index :order_items, [:order_id, :item_id], unique: true
  end
end
