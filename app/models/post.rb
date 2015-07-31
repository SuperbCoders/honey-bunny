class Post < ActiveRecord::Base
  include SuperbPages::Concerns::Models::Page
  include SuperbTextConstructor::Concerns::Models::Blockable

  before_validation :check_slug
  after_save :check_meta

  acts_as_taggable
  mount_uploader :cover, PageCoverUploader

  def to_param
    "#{id}-#{slug}"
  end

  private

  def check_slug
    return if slug.present?
    self[:slug] = title.parameterize.underscore
  end

  def check_meta
    return if meta_block.title.present?
    meta_block.update(title: title,
                      description: description,
                      keywords: tag_list.join(', '),
                      fb_title: title,
                      fb_description: description,
                      fb_image: cover
                      )
  end
end
