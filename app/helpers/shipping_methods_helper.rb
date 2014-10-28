module ShippingMethodsHelper

  # Returns icon name for specified shipping method
  # @param shipping_method [ShippingMethod]
  # @return [String] icon name for shipping method
  def shipping_method_icon(shipping_method)
    case shipping_method.name
    when 'courier' then 'moto'
    when 'regions' then 'truck'
    else 'truck'
    end
  end
end
