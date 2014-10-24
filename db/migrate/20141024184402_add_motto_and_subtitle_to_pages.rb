class AddMottoAndSubtitleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :motto, :string
    add_column :pages, :subtitle, :string
  end
end
