class CreateBlockCharts < ActiveRecord::Migration
  def change
    create_table :block_charts do |t|
      t.integer :block_id
      t.integer :value
      t.string :title
      t.string :color
      t.boolean :inverse_font_color, default: false

      t.timestamps
    end
    add_index :block_charts, :block_id
  end
end
