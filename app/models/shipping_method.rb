class ShippingMethod < ActiveRecord::Base
  RATE_TYPES = %w(fix_rate city_rate city_and_fix_rate)

  has_many :shipping_prices
  has_many :cities, through: :shipping_prices

  monetize :rate_cents
  monetize :extra_charge_cents

  validates :name, presence: true
  validates :title, presence: true
  validates :rate_type, presence: true, inclusion: { in: RATE_TYPES }
  validates :rate_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> (shipping_method) { %w(fix_rate city_and_fix_rate).include?(shipping_method.rate_type) }
  validates :extra_charge_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # @param options [Hash] calculation options
  # @option options [Integer] :city_id where to ship
  # @return [Float] price depending on shipping method rate type and options
  def calculate_price(options = {})
    price = case rate_type
    when 'fix_rate' then rate
    when 'city_rate'
      shipping_prices.where(city_id: options[:city_id]).first.try(:price)
    when 'city_and_fix_rate'
      shipping_prices.where(city_id: options[:city_id]).first.try(:price) || rate
    else nil
    end
    price.nil? ? nil : (price + extra_charge).to_f
  end
end
