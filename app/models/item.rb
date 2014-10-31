class Item < ActiveRecord::Base
  include SuperbTextConstructor::Concerns::Models::Blockable

  mount_uploader :main_image, ItemMainImageUploader

  monetize :price_cents

  has_and_belongs_to_many :reviews

  validates :title, presence: true
  validates :main_image, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }, unless: :negative_quantity_allowed?

  scope :available, -> { where('items.quantity > ? OR items.negative_quantity_allowed = ?', 0, true) }

  def to_param
    "#{id}-#{title.to_s.parameterize}"
  end

  # @param quantity [Integer] desired quantity
  # @return [Boolean] whether desired quantity is available to order
  def could_be_ordered?(quantity = 1)
    return true if negative_quantity_allowed?
    self.quantity - quantity >= 0
  end
end
