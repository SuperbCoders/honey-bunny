class AddOrderTypeToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :order_type, :string
    add_index :order_items, :order_type
    add_index :order_items, [:order_id, :order_type]
  end
end
