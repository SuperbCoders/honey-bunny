class SetDefaultShippingMethodAvailability < ActiveRecord::Migration
  def up
    execute("UPDATE shipping_methods SET available_for_default_order = true")
  end

  def down
  end
end
