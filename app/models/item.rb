class Item < ActiveRecord::Base
  mount_uploader :main_image, ItemMainImageUploader

  validates :title, presence: true
  validates :main_image, presence: true
end
