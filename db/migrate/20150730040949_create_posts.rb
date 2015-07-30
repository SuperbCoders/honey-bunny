class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.string :slug
      t.text :description
      t.boolean :published
      t.string :cover
      t.boolean :dark_cover, default: false

      t.timestamps
    end
  end
end
