class AddPriorityToShippingMethods < ActiveRecord::Migration
  def change
    add_column :shipping_methods, :priority, :integer
  end
end
