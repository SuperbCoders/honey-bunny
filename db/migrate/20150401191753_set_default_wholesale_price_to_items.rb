class SetDefaultWholesalePriceToItems < ActiveRecord::Migration
  def up
    execute("UPDATE items SET wholesale_price_cents = price_cents, wholesale_price_currency = price_currency")
  end

  def down
  end
end
