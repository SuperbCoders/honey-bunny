class Post < ActiveRecord::Base
  include SuperbPages::Concerns::Models::Page
  include SuperbTextConstructor::Concerns::Models::Blockable

  before_validation :check_slug

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
end
