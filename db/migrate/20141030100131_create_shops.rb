class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :logo
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :lat
      t.string :lon

      t.timestamps
    end
  end
end
