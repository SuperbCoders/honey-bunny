module OrdersHelper

  def order_city_options_for_select(cities, current, options = {})
    shipping_methods = options[:shipping_methods] || ShippingMethod.includes(:shipping_prices)
    collection = cities.map do |city|
      options = {}
      shipping_methods.each do |shipping_method|
        price = shipping_method.calculate_price(city_id: city.id)
        options["data-shipping-method-#{shipping_method.id}"] = humanized_money(price) if price
      end
      [city.name, city.name, options]
    end
    options_for_select(collection, current)
  end
end
