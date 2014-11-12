class OrdersController < ApplicationController
  layout 'item'

  before_action :check_cart, only: :new
  before_action :set_order, only: [:success]
  before_action :check_order_hash, only: [:success]

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
      reset_current_cart
      cookies[order_hash(@order)] = 'true' # Set cookie that allows to visit callbacks pages
      redirect_to success_order_url(@order)
    else
      set_lists
      render 'new'
    end
  end

  # GET /orders/:id/success
  def success
    cookies.delete order_hash(@order)
    render layout: 'simple'
  end

  private

    def check_cart
      redirect_to items_url if current_cart.empty_cart?
    end

    # Allow to visit some pages only with correct cookies
    def check_order_hash
      redirect_to root_url unless cookies[order_hash(@order)].present?
    end

    def order_params
      params.require(:order).permit(:shipping_method_id, :payment_method_id, :city, :zipcode, :address, :name, :phone, :email, :comment)
    end

    def set_lists
      @shipping_methods = ShippingMethod.includes(:shipping_prices).order(priority: :asc)
      @payment_methods = PaymentMethod.all
      @cities = City.all
    end

    def set_order
      @order = Order.find(params[:id])
    end

    def order_hash(order)
      Digest::SHA1.hexdigest("#{order.id}_#{order.created_at}")
    end
end
