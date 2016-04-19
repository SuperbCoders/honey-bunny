class ShippingMethod < ActiveRecord::Base
  RATE_TYPES = %w(fix_rate city_rate city_and_fix_rate individual)

  has_many :shipping_prices
  has_many :cities, through: :shipping_prices

  monetize :rate_cents
  monetize :extra_charge_cents

  validates :name, presence: true
  validates :title, presence: true
  validates :rate_type, presence: true, inclusion: { in: RATE_TYPES }
  validates :rate_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: -> (shipping_method) { %w(fix_rate city_and_fix_rate).include?(shipping_method.rate_type) }
  validates :extra_charge_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :priority, presence: true, numericality: { greater_than: 0 }

  before_validation :set_priority

  default_scope -> { order(priority: :asc) }

  # @param options [Hash] calculation options
  # @option options [Integer] :city_id where to ship
  # @return [Float] price depending on shipping method rate type and options
  def calculate_price(options = {})
    price = case rate_type
    when 'fix_rate' then rate
    when 'city_rate'

      if options[:total_price] and options[:city_id] == 1 and options[:total_price] > 1000
        return 0
      end

      shipping_prices.select { |sp| sp.city_id == options[:city_id] }.first.try(:price)
    when 'city_and_fix_rate'
      shipping_prices.select { |sp| sp.city_id == options[:city_id] }.first.try(:price) || rate
    when 'individual' then 0
    else nil
    end
    price.nil? ? nil : (price.to_f + extra_charge.to_f)
  end

  # @param options [Hash] options
  # @option options [Integer] :city_id where to ship
  # @return [Boolean] whether this shipping method is available with passed options
  def available?(options = {})
    case rate_type
    when 'fix_rate', 'city_and_fix_rate', 'individual' then true
    when 'city_rate' then shipping_prices.where(city_id: options[:city_id]).exists?
    else false
    end
  end

  private

    def set_priority
      self.priority ||= ShippingMethod.count + 1
    end
end
