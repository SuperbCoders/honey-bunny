class Order < ActiveRecord::Base
  include OrderBase

  belongs_to :shipping_method
  belongs_to :payment_method

  validates :shipping_method, presence: true
  validates :payment_method, presence: true
  validates :city, :address, :name, :phone, :email, presence: true
  validates :email, format: { with: /([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/ }
  validates :shipping_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_shipping_method

  before_validation :set_default_values

  def set_default_values
    self.shipping_method ||= ShippingMethod.find_by(name: 'courier')
    self.payment_method ||= PaymentMethod.find_by(name: 'cash')
    self.city ||= 'Москва'
    set_default_shipping_price
  end

  private

    # Validate that selected shipping method is available for this order
    def validate_shipping_method
      if shipping_method && !shipping_method.available?(city_id: city_id)
        errors.add(:shipping_method, :invalid)
      end
    end

end
