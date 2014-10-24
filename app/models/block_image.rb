class BlockImage < ActiveRecord::Base
  mount_uploader :image, BlockImageUploader
  belongs_to :block, inverse_of: :images
  validates_presence_of :image
end
