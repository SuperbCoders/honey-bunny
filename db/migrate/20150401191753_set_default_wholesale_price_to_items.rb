class SetDefaultWholesalePriceToItems < ActiveRecord::Migration
  def up
    Item.all.each do |item|
      item.update_attributes!(wholesale_price: item.price)
    end
  end

  def down
  end
end
