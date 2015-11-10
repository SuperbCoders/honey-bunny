class CartsController < ApplicationController
  before_action :set_item

  # POST /carts/items/:item_id
  def add
    @cart_item = current_cart.set(@item, quantity) || current_cart.cart_items.where(item_id: @item.id).first_or_initialize
    current_cart.reload
  end

  # DELETE /carts/items/:item_id
  def remove
    @cart_item = current_cart.remove(@item)
    current_cart.reload
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def quantity
    @quantity ||= (params[:quantity] || 1).to_i
  end
end
