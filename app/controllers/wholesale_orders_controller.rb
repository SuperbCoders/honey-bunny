class WholesaleOrdersController < ApplicationController
  include OrderHashable
  include OrderStoreable

  layout 'item'

  before_action :authenticate_wholesaler!
  before_action :set_lists
  before_action :set_wholesale_order, only: [:success]
  before_action :check_order_hash, only: [:success]

  # GET /wholesale_orders/new
  def new
    @wholesale_order = WholesaleOrder.new(stored_order_details(:wholesale_order))
    @wholesale_order.set_default_values
  end

  # POST /wholesales_orders
  def create
    @wholesale_order = WholesaleOrder.new(wholesale_order_params)
    @wholesale_order.use_cart(current_wholesale_cart)

    store_order_details(@wholesale_order)

    if @wholesale_order.save
      # Notify customer
      WholesaleOrderMailer.user_success_email(@wholesale_order.id, @wholesale_order.email).deliver!

      # Notify admins
      User.admins.notify_about_orders.each do |admin|
        WholesaleOrderMailer.admin_success_email(@wholesale_order.id, admin.email).deliver! if admin.email.present?
      end

      reset_current_wholesale_cart
      cookies[order_hash(@wholesale_order)] = 'true' # Set cookie that allows to visit callbacks pages
      redirect_to success_wholesale_order_url(@wholesale_order)
    else
      set_lists
      render :new
    end
  end

  # GET /wholesale_orders/:id/success
  def success
    cookies.delete order_hash(@order)
    render template: 'orders/success', layout: 'simple'
  end

  private

    def authenticate_wholesaler!
      if current_wholesaler
        redirect_to pending_wholesalers_url unless current_wholesaler.approved?
      else
        redirect_to new_wholesaler_url
      end
    end

    def set_lists
      @shipping_methods = ShippingMethod.where(available_for_wholesale_order: true).includes(:shipping_prices).order(priority: :asc)
      @items = Item.not_deleted
      @cities = City.all
    end

    def set_wholesale_order
      @order = WholesaleOrder.find(params[:id])
    end

    def wholesale_order_params
      params.require(:wholesale_order).permit(:shipping_method_id, :payment_method_id, :city, :zipcode, :address, :name, :phone, :email, :comment)
    end
end
