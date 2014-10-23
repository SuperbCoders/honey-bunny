class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.string :main_image
      t.string :motto
      t.integer :volume
      t.text :short_description

      t.timestamps
    end
  end
end
