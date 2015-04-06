module MerchantHelper
  # Generates payment form
  # @param object [Order, Registration] object that should be paid
  # @param options [Hash] payment form options
  # @option options [Integer] :amount total price of object
  # @option options [String] :description description of payment
  # @option options [Hash] :customer customer info: first name, last name, email
  # @return [String] payment form HTML
  def payment_form_for(object, options = {})
    klass = object.class.name.underscore
    payment_service_for "#{klass}-#{object.id.to_s}-#{Rails.env}", Settings::W1.merchant_id,
                        html: { authenticity_token: false, enforce_utf8: false, id: 'js-payment-form' },
                        amount: options[:amount],
                        service: :w1,
                        currency: 643, # in RUR
                        secret: Settings::W1.signature do |s|
      s.add_field :WMI_SUCCESS_URL, w1_success_url(klass, object.id)
      s.add_field :WMI_FAIL_URL, w1_fail_url(klass, object.id)
      s.add_field :WMI_DESCRIPTION, "BASE64:#{Base64.strict_encode64(options[:description])}"

      if options[:customer] && options[:customer].is_a?(Hash)
        s.add_field :WMI_CUSTOMER_FIRSTNAME, options[:customer][:first_name] if options[:customer][:first_name].present?
        s.add_field :WMI_CUSTOMER_LASTNAME, options[:customer][:last_name] if options[:customer][:last_name].present?
        s.add_field :WMI_CUSTOMER_EMAIL, options[:customer][:email] if options[:customer][:email].present?
      end

      if options[:recipient_login].present?
        s.add_field :WMI_RECIPIENT_LOGIN, options[:recipient_login]
      end

      s.fields[ActiveMerchant::Billing::Integrations::W1.signature_parameter_name] = s.generate_signature
      submit_tag "Оплатить", name: nil
    end
  end
end
