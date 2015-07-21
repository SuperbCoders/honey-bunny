class OrdersController < ApplicationController
  include OrderHashable

  layout 'item'

  before_action :check_cart, only: :new
  before_action :set_order, only: [:payment, :success, :fail]
  before_action :check_order_hash, only: [:payment, :success, :fail]

  # GET /orders/new
  def new
    @order = Order.new
    @order.use_cart(current_cart)
    @order.set_default_values
    set_lists
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    @order.use_cart(current_cart)
    if @order.save
      # Notify customer
      OrderMailer.user_success_email(@order.id, @order.email).deliver! if @order.email

      # Notify admins
      User.admins.notify_about_orders.each do |admin|
        OrderMailer.admin_success_email(@order.id, admin.email).deliver! if admin.email.present?
      end

      reset_current_cart
      cookies[order_hash(@order)] = 'true' # Set cookie that allows to visit callbacks pages

      # Redirect to the next page
      redirect_to @order.payment_method.name == 'w1' ? payment_order_url(@order) : success_order_url(@order)
    else
      set_lists
      render 'new'
    end
  end

  # GET /orders/:id/payment
  def payment
    render layout: false
  end

  # GET /orders/:id/success
  def success
    cookies.delete order_hash(@order)
    render layout: 'simple'
  end

  # GET /orders/:id/fail
  def fail
    cookies.delete order_hash(@order)
    render layout: 'simple'
  end

  private

  def check_cart
    redirect_to items_url if current_cart.empty_cart?
  end

  def order_params
    added_params = mobile_device? ? {from_mobile: true} : {}
    params.require(:order).permit(:shipping_method_id, :payment_method_id,
                                  :city, :zipcode, :address, :name,
                                  :phone, :email, :comment, :zip_code).merge(added_params)
  end

  def set_lists
    @shipping_methods = ShippingMethod.where(available_for_default_order: true).includes(:shipping_prices).order(priority: :asc)
    @payment_methods = PaymentMethod.all
    @cities = City.all
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
