class AddCoverToPages < ActiveRecord::Migration
  def change
    add_column :pages, :cover, :string
  end
end
