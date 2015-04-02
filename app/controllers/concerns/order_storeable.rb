module OrderStoreable

  protected

    def stored_attributes
      %w(shipping_method_id payment_method_id name phone email city zipcode address)
    end

    # Stores details of the order to the cookies to use them for the next order
    # @param order [Order] order that should be stored
    def store_order_details(order)
      details = {}
      stored_attributes.each do |attribute|
        details[attribute.to_sym] = order.try(attribute)
      end
      cookies.permanent["last_#{order.class.name.underscore}_details"] = ActiveSupport::JSON.encode(details)
    end

    # @return [Hash] details of the last order or empty hash if there are no stored details
    def stored_order_details(prefix)
      key = "last_#{prefix.to_s}_details"
      details = cookies[key].present? ? ActiveSupport::JSON.decode(cookies[key]) : {}
      details.select { |key, value| stored_attributes.include?(key.to_s) }
    end
end
