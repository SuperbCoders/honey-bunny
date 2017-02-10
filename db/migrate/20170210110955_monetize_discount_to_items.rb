class MonetizeDiscountToItems < ActiveRecord::Migration
  def change
    add_money :items, :discount
  end
end
