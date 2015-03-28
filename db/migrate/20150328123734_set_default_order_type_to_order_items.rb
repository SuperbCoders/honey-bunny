class SetDefaultOrderTypeToOrderItems < ActiveRecord::Migration
  def up
    execute("UPDATE order_items SET order_type='Order'")
  end

  def down
  end
end
