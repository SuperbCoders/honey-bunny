class Block < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Models::Block

  has_and_belongs_to_many :items

  has_many :images, class_name: 'BlockImage', inverse_of: :block
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :elements, class_name: 'BlockElement', inverse_of: :block
  accepts_nested_attributes_for :elements, allow_destroy: true

  has_many :charts, class_name: 'BlockChart', inverse_of: :block
  accepts_nested_attributes_for :charts, allow_destroy: true

  validate :validate_images_presence, if: -> (block) { block.fields['images'].try(:fetch, 'required', nil) == true }
  validate :validate_elements_presence, if: -> (block) { block.fields['elements'].try(:fetch, 'required', nil) == true }
  validate :validate_charts_presence, if: -> (block) { block.fields['charts'].try(:fetch, 'required', nil) == true }

  private

    # Block should contain at least 1 image if it is required
    def validate_images_presence
      errors.add(:images, :presence) if images.empty?
    end

    # Block should contain at least 1 element if it is required
    def validate_elements_presence
      errors.add(:elements, :presence) if elements.empty?
    end

    # Block should contain at least 1 chart if it is required
    def validate_charts_presence
      errors.add(:charts, :presence) if charts.empty?
    end
end
