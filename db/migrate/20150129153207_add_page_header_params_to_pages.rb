class AddPageHeaderParamsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :dark_cover, :boolean, default: true
    add_column :pages, :shadow_cover, :boolean, default: true
  end
end
