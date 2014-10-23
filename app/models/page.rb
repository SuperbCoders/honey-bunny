class Page < ActiveRecord::Base
  include SuperbPages::Concerns::Models::Page

  # @return [Boolean] whether anyone can destroy this page
  def destroyable?
    %w(index).include?(slug)
  end
end
