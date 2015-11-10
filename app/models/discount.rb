class Discount < ActiveRecord::Base
  enum kind: [:value, :percent]
  enum mode: [:disposable, :reusable]

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  before_validation :generate_code

  def total(items_price = 0)
    value? ? amount : items_price.to_f * amount / 100
  end

  private

  def generate_code
    return if code.present?
    self[:code] = loop do
                    token = SecureRandom.uuid.tr('-', '')[0..7]
                    break token unless Discount.exists?(code: token)
                  end
  end
end
