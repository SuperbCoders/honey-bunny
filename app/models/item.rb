class Item < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Models::Blockable

  mount_uploader :main_image, ItemMainImageUploader

  monetize :price_cents

  validates :title, presence: true
  validates :main_image, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

end
