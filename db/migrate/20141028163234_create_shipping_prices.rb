class CreateShippingPrices < ActiveRecord::Migration
  def change
    create_table :shipping_prices do |t|
      t.integer :city_id
      t.integer :shipping_method_id
      t.money :price

      t.timestamps
    end
    add_index :shipping_prices, :city_id
    add_index :shipping_prices, :shipping_method_id
    add_index :shipping_prices, [:shipping_method_id, :city_id], unique: true
  end
end
