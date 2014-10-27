class CreateBlocksItems < ActiveRecord::Migration
  def change
    create_table :blocks_items do |t|
      t.integer :block_id
      t.integer :item_id
    end
    add_index :blocks_items, :block_id
    add_index :blocks_items, :item_id
    add_index :blocks_items, [:block_id, :item_id], unique: true
  end
end
