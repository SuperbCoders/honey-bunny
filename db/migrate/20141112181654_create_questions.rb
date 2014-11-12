class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.text :text
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
    add_index :questions, :user_id
  end
end
