class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :shipping_method_id
      t.integer :payment_method_id
      t.string :workflow_state
      t.boolean :paid, default: false
      t.string :city
      t.string :zipcode
      t.text :address
      t.string :name
      t.string :phone
      t.string :email
      t.text :comment
      t.money :shipping_price

      t.timestamps
    end
    add_index :orders, :shipping_method_id
    add_index :orders, :payment_method_id
  end
end
