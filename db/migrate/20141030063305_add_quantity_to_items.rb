class AddQuantityToItems < ActiveRecord::Migration
  def change
    add_column :items, :quantity, :integer, default: 0
    add_column :items, :negative_quantity_allowed, :boolean, default: false
  end
end
