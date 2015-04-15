class WholesaleOrder < ActiveRecord::Base
  include OrderBase

  belongs_to :wholesaler
  belongs_to :shipping_method
  belongs_to :payment_method

  before_validation :set_default_values

  validates :shipping_method, presence: true
  validates :payment_method, presence: true
  validates :city, :address, presence: true, unless: :own_expense?
  validates :name, :phone, :email, presence: true
  validates :email, format: { with: /([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/ }
  validates :shipping_price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # validate :validate_shipping_method

  def set_default_values
    self.shipping_method ||= ShippingMethod.find_by(name: 'own_expense')
    self.payment_method ||= PaymentMethod.find_by(name: 'cash')
    self.city ||= 'Москва'
    set_default_shipping_price
  end

  def own_expense?
    shipping_method.try(:name) == 'own_expense'
  end

  protected

    def item_price_method_name
      :wholesale_price
    end
end
