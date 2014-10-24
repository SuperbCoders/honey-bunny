class Page < ActiveRecord::Base
  SYSTEM_PAGES = %w(index products)

  include SuperbPages::Concerns::Models::Page
  include SuperbTextConstructor::Concerns::Models::Blockable

  mount_uploader :cover, PageCoverUploader

  validates :cover, presence: true

  # @return [Boolean] whether anyone can destroy this page
  def destroyable?
    SYSTEM_PAGES.include?(slug)
  end
end
