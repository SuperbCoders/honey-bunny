class CreateWholesaleCarts < ActiveRecord::Migration
  def change
    create_table :wholesale_carts do |t|
      t.string :token

      t.timestamps
    end
    add_index :wholesale_carts, :token, unique: true
  end
end
