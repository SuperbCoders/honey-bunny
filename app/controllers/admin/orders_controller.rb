class Admin::OrdersController < Admin::ApplicationController
  before_action { authorize! :manage, Order }
  before_action :set_order, only: [:edit, :update]

  # GET /admin/orders
  def index
    @orders = Order.order(created_at: :desc)
    @orders = @orders.where(workflow_state: params[:workflow_state]) if params[:workflow_state].present?
    @total_price = OrderItem.where(order_id: @orders.pluck(:id)).sum('price_cents * quantity') / 100
    @total_count = @orders.count
  end

  # GET /admin/orders/:id/edit
  def edit
  end

  # PATCH/PUT /admin/orders/:id
  def update
    if @order.update_attributes(order_params)
      redirect_to edit_admin_order_url(@order), notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:shipping_method_id, :payment_method_id, :city, :zipcode, :address, :name, :phone, :email, :comment, :shipping_price, :paid)
    end

end
