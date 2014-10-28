class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods do |t|
      t.string :name
      t.string :title
      t.string :rate_type
      t.money :rate
      t.money :extra_charge

      t.timestamps
    end
    add_index :shipping_methods, :name, unique: true
  end
end
