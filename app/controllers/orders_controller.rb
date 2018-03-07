class OrdersController < ApplicationController
  include OrderHashable

  layout 'item'

  before_action :check_cart, only: :new
  before_action :set_order, only: [:payment, :success, :fail]
  before_action :check_order_hash, only: [:payment, :success, :fail]

  def new
    @order = Order.new
    @order.use_cart(current_cart)
    @order.set_default_values
    set_lists
  end

  def create
    @order = Order.new(order_params)
    @order.use_cart(current_cart)
    if @order.save
      # Notify customer
      OrderMailer.user_success_email(@order.id, @order.email).deliver! if @order.email and not_email(@order.comment)

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

  def check_discount
    discount_code = params[:discount_code]
    discount = Discount.active.find_by(code: discount_code)

    if discount
      data = discount
      status = 200
    else
      data = {
        error: 'Введенный вами купон не существует или просрочен'
      }
      status = 404
    end
    render json: data.as_json, status: status
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

  def not_email text
    !text.match(/([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/)
  end

  def check_cart
    redirect_to items_url if current_cart.empty_cart?
  end

  def order_params
    added_params = mobile_device? ? {from_mobile: true} : {}
    params.require(:order).permit(:shipping_method_id, :payment_method_id,
                                  :city, :zipcode, :address, :name,
                                  :phone, :email, :comment, :zip_code,
                                  :discount_id
                                  ).merge(added_params)
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
