class AddTokenIndexToCarts < ActiveRecord::Migration
  def change
    add_index :carts, :token, unique: true
  end
end
