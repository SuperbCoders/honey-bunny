class AddNotifyAboutWholesalersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_about_wholesalers, :boolean, default: false
  end
end
