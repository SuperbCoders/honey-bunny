class CreateBlockImages < ActiveRecord::Migration
  def change
    create_table :block_images do |t|
      t.integer :block_id
      t.string :image

      t.timestamps
    end
    add_index :block_images, :block_id
  end
end
