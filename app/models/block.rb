class Block < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Models::Block

  has_many :images, class_name: 'BlockImage', inverse_of: :block
  accepts_nested_attributes_for :images, allow_destroy: true

  validate :validate_images_presence, if: -> (block) { block.fields['images'].try(:fetch, 'required', nil) == true }

  private

    # Block should contain at least 1 image if it is required
    def validate_images_presence
      errors.add(:images, :presence) if images.empty?
    end
end
