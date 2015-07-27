class Cabinet::CartsController < Cabinet::BaseController
  before_action :set_item

  def add
    @cart_item = current_wholesale_cart.set(@item, quantity) || current_wholesale_cart.cart_items.where(item_id: @item.id).first_or_initialize
    current_wholesale_cart.reload
    render layout: false
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def quantity
    @quantity ||= (params[:quantity] || 1).to_i
  end
end
