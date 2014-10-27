class CreateBlockElements < ActiveRecord::Migration
  def change
    create_table :block_elements do |t|
      t.integer :block_id
      t.string :image
      t.string :title
      t.text :text

      t.timestamps
    end
    add_index :block_elements, :block_id
  end
end
