class MetaBlock < ActiveRecord::Base
  include SuperbPages::Concerns::Models::MetaBlock

  # @return [MetaBlock] default meta block
  def self.default
    MetaBlock.where(default: true).first_or_create
  end

  # Merges one meta block to another
  # @param meta_block [MetaBlock] meta block that should be merged into this one
  # @return [MetaBlock] this meta block with merged attributes
  def merge(meta_block)
    self.title = meta_block.title if title.blank?
    self.description = meta_block.description if description.blank?
    self.keywords = meta_block.keywords if keywords.blank?
    self.javascript = meta_block.javascript if javascript.blank?
    self.fb_image = meta_block.fb_image unless fb_image?
    self.fb_title = meta_block.fb_title if fb_title.blank?
    self.fb_description = meta_block.fb_description if fb_description.blank?
    self
  end
end
