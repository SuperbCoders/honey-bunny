module OrderBase
  extend ActiveSupport::Concern

  included do
    include Workflow

    workflow do
      state :new do
        event :ship, transitions_to: :shipped
        event :deliver, transitions_to: :delivered
        event :cancel, transitions_to: :canceled
      end
      state :shipped do
        event :deliver, transitions_to: :delivered
        event :cancel, transitions_to: :canceled
      end
      state :delivered
      state :canceled
    end

    monetize :shipping_price_cents

    has_many :order_items, inverse_of: :order, dependent: :destroy, as: :order
    accepts_nested_attributes_for :order_items, allow_destroy: true
  end

  # Adds items from the cart to the order
  # @param cart [Cart] cart that should be used
  def use_cart(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(item_id: cart_item.item.id, price: cart_item.item.price, quantity: cart_item.quantity)
    end
  end

  # @return [Float] total price of all items + shipping price
  def total_price
    items_price + shipping_price
  end

  # @return [Float] total price of all items
  def items_price
    order_items.to_a.sum(&:total_price)
  end

  # @return [Boolean] whether its items could be edited
  def editable?
    new?
  end

  # @return [String] full address
  def full_address
    [zipcode, city, address].select(&:present?).join(', ')
  end
end
