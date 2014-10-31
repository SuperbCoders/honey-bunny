class CreateItemsReviews < ActiveRecord::Migration
  def change
    create_table :items_reviews do |t|
      t.integer :item_id
      t.integer :review_id
    end
    add_index :items_reviews, :item_id
    add_index :items_reviews, :review_id
    add_index :items_reviews, [:review_id, :item_id], unique: true
  end
end
