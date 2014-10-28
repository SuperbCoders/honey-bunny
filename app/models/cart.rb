class Cart < ActiveRecord::Base
  has_many :cart_items, inverse_of: :cart

  validates :token, presence: true

  before_validation :set_token

  # @return [Boolean] whether cart is empty
  def empty_cart?
    total_quantity == 0
  end

  # @return [Integer] total quantity of items in cart
  def total_quantity
    cart_items.sum(:quantity)
  end

  # @return [Integer] total price of all items
  def total_price
    cart_items.to_a.sum(&:total_price)
  end

  # Sets specified quantity of the item
  # @param item [Item] item which quantity should be set
  # @param quantity [Integer] new quantity of the item
  # @return [CartItem] added item if everything is ok
  # @return [nil] if item was not added to the cart
  def set(item, quantity)
    quantity = 0 if !quantity.is_a?(Integer) || quantity < 0
    cart_item = cart_items.where(item_id: item.id).first_or_initialize(cart: self)
    cart_item.quantity = quantity
    quantity > 0 ? cart_item.save! : remove(item)
    cart_item
  end

  # Removes item from the cart
  # @param item [Item] item that should be removed
  # @return [CartItem] removed cart item
  # @return [nil] if nothing was removed
  def remove(item)
    cart_items.where(item_id: item.id).first.try(:destroy)
  end

  private

    # @return [String] unique cart token
    def self.generate_token
      token = SecureRandom.hex(32)
      Cart.exists?(token: token) ? generate_token : token
    end

    # Sets token for created cart
    def set_token
      self.token ||= Cart.generate_token
    end

end
