module OrderHashable
  protected

    # Allow to visit some pages only with correct cookies
    def check_order_hash
      redirect_to root_url unless cookies[order_hash(@order)].present?
    end

    def order_hash(order)
      Digest::SHA1.hexdigest("#{order.id}_#{order.created_at}")
    end
end
