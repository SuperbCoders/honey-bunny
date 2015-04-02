class CreateWholesaleOrders < ActiveRecord::Migration
  def change
    create_table :wholesale_orders do |t|
      t.references :wholesaler, index: true
      t.references :shipping_method, index: true
      t.references :payment_method, index: true
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
  end
end
