class Admin::OrdersController < Admin::ApplicationController
  include WorkflowController

  workflow_events :ship, :deliver, :cancel

  before_action { authorize! :manage, Order }
  before_action :set_order, only: [:edit, :update, :ship, :deliver, :cancel]

  # GET /admin/orders
  def index
    @orders = Order.includes(:shipping_method, :payment_method, order_items: :item).order(created_at: :desc)
    @orders = @orders.where(workflow_state: params[:workflow_state]) if params[:workflow_state].present?
    @orders = @orders.where(created_at: from_to) if from_to
    @total_price = OrderItem.where(order_type: 'Order', order_id: @orders.pluck(:id)).sum('price_cents * quantity') / 100
    @total_count = @orders.count

    @orders = @orders.page(params[:page]).per(25)
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
    params.require(:order).permit(:shipping_method_id, :payment_method_id, :city, :zipcode, :address, :name, :phone, :email, :comment, :admin_comment, :shipping_price, :paid)
  end

  def from_to
    return if params[:from].blank? && params[:to].blank?
    @from = DateTime.parse(params[:from]).beginning_of_day
    @to = (params[:to] ? DateTime.parse(params[:to]) : DateTime.now).end_of_day
    @from..@to
  end

end
