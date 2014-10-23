class MonetizeItem < ActiveRecord::Migration
  def change
    add_money :items, :price
  end
end
