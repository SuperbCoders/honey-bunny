class Page < ActiveRecord::Base
  SYSTEM_PAGES = %w(index products)

  include SuperbPages::Concerns::Models::Page
  include SuperbTextConstructor::Concerns::Models::Blockable

  mount_uploader :cover, PageCoverUploader

  validates :cover, presence: true

  # @return [Boolean] whether this is system page
  def system?
    SYSTEM_PAGES.include?(slug)
  end
  alias :destroyable? :system?
end
