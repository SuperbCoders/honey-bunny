class WholesaleCart < ActiveRecord::Base
  include CartBase

  after_create :setup_items

  def setup_items
    # Destroy unavailable items
    cart_items.each do |cart_item|
      cart_item.destroy! unless available_items.map(&:id).include?(cart_item.item_id)
    end
    # Get IDs of all cart items
    item_ids = cart_items.reload.pluck(:item_id)
    # Create not added available items
    available_items.each do |item|
      cart_items.create!(item: item, quantity: 0) unless item_ids.include?(item.id)
    end
  end

  private

    def available_items
      @available_items ||= Item.available
    end
end
