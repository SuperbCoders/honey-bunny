module PaymentMethodsHelper
  # Returns icon name for specified payment method
  # @param payment_method [PaymentMethod]
  # @return [String] icon name for payment method
  def payment_method_icon(payment_method)
    case payment_method.name
    when 'cash' then 'money'
    when 'w1' then 'card'
    else 'card'
    end
  end
end
