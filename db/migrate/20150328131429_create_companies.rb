class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.references :member, polymorphic: true, index: true
      t.string :name
      t.text :address
      t.string :inn
      t.string :kpp
      t.string :ogrn
      t.string :okpo
      t.text :bank_details

      t.timestamps
    end
  end
end
