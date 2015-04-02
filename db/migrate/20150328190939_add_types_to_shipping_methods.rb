class AddTypesToShippingMethods < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :available_for_default_order, :boolean, default: false
    add_column :shipping_methods, :available_for_wholesale_order, :boolean, default: false
  end
end
