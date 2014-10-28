class CartItem < ActiveRecord::Base
  belongs_to :cart, inverse_of: :cart_items
  belongs_to :item

  validates :cart, presence: true
  validates :item, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  delegate :price, to: :item

  # @return [Integer] total price of this line
  def total_price
    price * quantity
  end
end
