class BlockElement < ActiveRecord::Base
  mount_uploader :image, BlockElementUploader
  belongs_to :block, inverse_of: :elements
  validates_presence_of :image, :title, :text
end
