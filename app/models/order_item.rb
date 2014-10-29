class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :item

  monetize :price_cents

  validates :order, presence: true
  validates :item, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # @return [Float] total price of items
  def total_price
    price * quantity
  end
end
