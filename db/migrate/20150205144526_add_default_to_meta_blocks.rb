class AddDefaultToMetaBlocks < ActiveRecord::Migration
  def change
    add_column :meta_blocks, :default, :boolean, default: false
  end
end
