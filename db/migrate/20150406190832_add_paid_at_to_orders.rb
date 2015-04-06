class AddPaidAtToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :paid_at, :datetime
    add_column :wholesale_orders, :paid_at, :datetime
  end
end
