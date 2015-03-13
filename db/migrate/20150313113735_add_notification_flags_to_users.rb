class AddNotificationFlagsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_about_orders, :boolean, default: false
    add_index :users, :notify_about_orders
    add_column :users, :notify_about_questions, :boolean, default: false
    add_index :users, :notify_about_questions
  end
end
