class ShippingPrice < ActiveRecord::Base
  belongs_to :city
  belongs_to :shipping_method

  monetize :price_cents

  validates :city, presence: true
  validates :shipping_method, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_shipping_method_rate_type

  private

    def validate_shipping_method_rate_type
      errors.add(:shipping_method, :must_be_city_rate) unless %w(city_rate city_and_fix_rate).include?(shipping_method.try(:rate_type))
    end
end
