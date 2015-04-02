class SetDefaultCartTypeToCartItems < ActiveRecord::Migration
  def up
    execute("UPDATE cart_items SET cart_type='Cart'")
  end

  def down
  end
end
