class Admin::OrderItemsController < Admin::ApplicationController
  layout false
  before_action { authorize! :manage, Order }
  before_action :set_order
  before_action :set_order_item, only: [:edit, :update, :destroy]

  # GET /admin/orders/:order_id/order_items/new
  def new
    @order_item = @order.order_items.build
    @items = Item.available
  end

  # POST /admin/orders/:order_id/order_items
  def create
    @order_item = @order.order_items.build(order_item_params)
    if @order_item.save
      redirect_to edit_admin_order_url(@order), notice: I18n.t('shared.saved')
    else
      redirect_to edit_admin_order_url(@order), alert: I18n.t('shared.not_saved')
    end
  end

  # GET /admin/orders/:order_id/order_items/:id/edit
  def edit
    @items = [Item.available.to_a, @order_item.item].flatten.uniq(&:id)
  end

  # PUT/PATCH /admin/orders/:order_id/order_items/:id
  def update
    if @order_item.update_attributes(order_item_params)
      redirect_to edit_admin_order_url(@order), notice: I18n.t('shared.saved')
    else
      redirect_to edit_admin_order_url(@order), alert: I18n.t('shared.not_saved')
    end
  end

  # DELETE /admin/orders/:order_id/order_items/:id
  def destroy
    if @order_item.destroy
      redirect_to edit_admin_order_url(@order), notice: I18n.t('shared.saved')
    else
      redirect_to edit_admin_order_url(@order), alert: I18n.t('shared.not_saved')
    end
  end

  private

    def set_order
      @order = Order.find(params[:order_id])
    end

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:item_id, :quantity)
    end
end