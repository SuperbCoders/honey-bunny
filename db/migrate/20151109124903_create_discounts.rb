class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :code
      t.integer :amount
      t.integer :kind, default: 0
      t.integer :mode, default: 0
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :discounts, :code, unique: true
  end
end
