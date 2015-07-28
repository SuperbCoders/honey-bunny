class Material < ActiveRecord::Base
  mount_uploader :file, MaterialUploader

  validates :title, presence: true
  validates :file, presence: true
end
