class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :rating
      t.string :name
      t.string :email
      t.string :city
      t.text :message
      t.string :workflow_state
      t.string :place

      t.timestamps
    end
    add_index :reviews, :user_id
  end
end
