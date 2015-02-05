class Order < ActiveRecord::Base
  include Workflow
  monetize :shipping_price_cents

  belongs_to :shipping_method
  belongs_to :payment_method

  has_many :order_items, inverse_of: :order, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :shipping_method, presence: true
  validates :payment_method, presence: true
  validates :city, :zipcode, :address, :name, :phone, :email, presence: true
  validates :email, format: { with: /([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/ }
  validates :shipping_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_shipping_method

  before_validation :set_default_values

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

  def set_default_values
    self.shipping_method ||= ShippingMethod.find_by(name: 'courier')
    self.payment_method ||= PaymentMethod.find_by(name: 'cash')
    self.city ||= 'Москва'
    set_default_shipping_price
  end

  # Special rules for default shipping price value
  def set_default_shipping_price
    if new_record? || shipping_price.blank?
      self.shipping_price = shipping_method.try(:calculate_price, { city_id: city_id }) || 0
    end
  end

  # @return [Boolean] whether its items could be edited
  def editable?
    new?
  end

  # @return [String] full address
  def full_address
    [zipcode, city, address].select(&:present?).join(', ')
  end

  private

    # Validate that selected shipping method is available for this order
    def validate_shipping_method
      if shipping_method && !shipping_method.available?(city_id: city_id)
        errors.add(:shipping_method, :invalid)
      end
    end

    # @reutrn [Integer] id of the selected city
    # @reutrn [nil] if city was not found
    def city_id
      City.where(name: city).pluck(:id).first
    end

    # Rollback items' quantities
    def cancel
      order_items.each { |oi| oi.increase_item_quantity(force: true) }
    end
end
