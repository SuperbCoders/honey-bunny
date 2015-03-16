class AddOfficialToShops < ActiveRecord::Migration
  def change
    add_column :shops, :official, :boolean, default: true
  end
end
