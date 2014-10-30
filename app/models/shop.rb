class Shop < ActiveRecord::Base
  mount_uploader :logo, ShopLogoUploader

  validates :logo, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true, format: { with: /([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/ }
end
