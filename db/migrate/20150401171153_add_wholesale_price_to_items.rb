class AddWholesalePriceToItems < ActiveRecord::Migration
  def change
    add_money :items, :wholesale_price
  end
end
