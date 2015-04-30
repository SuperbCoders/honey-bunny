class Admin::WholesaleOrdersController < Admin::ApplicationController
  include WorkflowController

  workflow_events :ship, :deliver, :cancel

  before_action { authorize! :manage, WholesaleOrder }
  before_action :set_order, only: [:edit, :update, :ship, :deliver, :cancel]

  # GET /admin/wholesale_orders
  def index
    @orders = WholesaleOrder.includes(:shipping_method, :payment_method, order_items: :item).order(created_at: :desc)
    @orders = @orders.where(workflow_state: params[:workflow_state]) if params[:workflow_state].present?
    @total_price = OrderItem.where(order_type: 'WholesaleOrder', order_id: @orders.pluck(:id)).sum('price_cents * quantity') / 100
    @total_count = @orders.count

    @orders = @orders.page(params[:page]).per(25)
  end

  # GET /admin/wholesale_orders/:id/edit
  def edit
  end

  # PATCH/PUT /admin/wholesale_orders/:id
  def update
    if @order.update_attributes(order_params)
      redirect_to url_for([:edit, :admin, @order]), notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  private

    def set_order
      @order = WholesaleOrder.find(params[:id])
      @wholesale_order = @order # Alias for correct work of WorkflowController concern
    end

    def order_params
      params.require(:wholesale_order).permit(:shipping_method_id, :payment_method_id, :city, :zipcode, :address, :name, :phone, :email, :comment, :shipping_price, :paid)
    end

end
