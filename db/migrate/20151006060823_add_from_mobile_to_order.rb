class AddFromMobileToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :from_mobile, :boolean, default: false
  end
end
