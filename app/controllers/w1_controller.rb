class W1Controller < ApplicationController
  include ActiveMerchant::Billing::Integrations
  before_action :create_notification
  skip_before_action :verify_authenticity_token

  def callback
    if @notification.acknowledge
      klass, id = @notification.item_id.split('-')
      case klass
      when 'order' then proccess_order(id)
      when 'wholesale_order' then proccess_wholesale_order(id)
      end
      render text: @notification.success_response
    else
      head :bad_request
    end
  end

  def success
    case params[:klass]
    when 'order' then redirect_to success_order_url(params[:id])
    when 'wholesale_order' then redirect_to success_wholesale_order_url(params[:id])
    else redirect_to root_url
    end
  end

  def fail
    case params[:klass]
    when 'order' then redirect_to fail_order_url(params[:id])
    when 'wholesale_order' then redirect_to fail_wholesale_order_url(params[:id])
    else redirect_to root_url
    end
  end

  private

    def create_notification
      @notification = W1::Notification.new(request.raw_post, secret: Settings::W1.signature)
    end

    def proccess_order(order_id)
      order = Order.find_by(id: order_id)
      if order && !order.paid?
        order.update_column(:paid, true)
        order.update_column(:paid_at, Time.now)
      end
    end

    def proccess_wholesale_order(order_id)
      order = WholesaleOrder.find_by(id: order_id)
      if order && !order.paid?
        order.update_column(:paid, true)
        order.update_column(:paid_at, Time.now)
      end
    end

end