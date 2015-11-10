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

    after_commit :check_discount, on: [:create]

    has_many :order_items, inverse_of: :order, dependent: :destroy, as: :order
    accepts_nested_attributes_for :order_items, allow_destroy: true

    belongs_to :discount
  end

  # Adds items from the cart to the order
  # @param cart [Cart] cart that should be used
  def use_cart(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(item_id: cart_item.item.id, price: cart_item.item.send(item_price_method_name), quantity: cart_item.quantity) if cart_item.quantity.to_i > 0
    end
  end

  # @return [Float] order discount
  def discount_amount
    return 0 unless discount && discount.active?
    discount.total(items_price)
  end

  # @return [Float] total price of all items + shipping price without discount
  def total_price_without_discount
    items_price.to_f + shipping_price.to_f
  end

  # @return [Float] total price of all items + shipping price - discount
  def total_price
    total_price_without_discount.to_f - discount_amount.to_f
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

  # Special rules for default shipping price value
  def set_default_shipping_price
    if new_record? || shipping_price.blank?
      self.shipping_price = shipping_method.try(:calculate_price, { city_id: city_id }) || 0
    end
  end

  def check_discount
    return unless discount && discount.disposable?
    discount.update(active: false)
  end

  protected

  # Rollback items' quantities
  def cancel
    order_items.each { |oi| oi.increase_item_quantity(force: true) }
  end

  # @reutrn [Integer] id of the selected city
  # @reutrn [nil] if city was not found
  def city_id
    City.where(name: city).pluck(:id).first
  end

  # @return [Symbol] name of the Item's method that returns proper product price
  def item_price_method_name
    :price
  end
end
