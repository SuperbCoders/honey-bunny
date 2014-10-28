class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
    add_index :cart_items, :cart_id
    add_index :cart_items, :item_id
    add_index :cart_items, [:cart_id, :item_id], unique: true
  end
end
