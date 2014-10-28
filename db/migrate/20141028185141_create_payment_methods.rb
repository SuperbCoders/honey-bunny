class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.string :title

      t.timestamps
    end
    add_index :payment_methods, :name, unique: true
  end
end
