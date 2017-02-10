class CartItem < ActiveRecord::Base
  belongs_to :cart, inverse_of: :cart_items, polymorphic: true
  belongs_to :item

  validates :cart, presence: true
  validates :item, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }, unless: :wholesale?
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :wholesale?

  # @return [Integer] total price of this line
  def total_price
    price * quantity
  end

  def price
    if wholesale?
      item.wholesale_price
    else
      if item.discount > 0
        item.discount
      else
        item.price
      end
    end
  end

  private

    def wholesale?
      cart.is_a?(WholesaleCart)
    end
end
