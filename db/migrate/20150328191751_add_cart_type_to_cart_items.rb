class AddCartTypeToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :cart_type, :string
    add_index :cart_items, :cart_type
    add_index :cart_items, [:cart_id, :cart_type]
  end
end
