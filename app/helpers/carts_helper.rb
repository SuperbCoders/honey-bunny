module CartsHelper

  # @return [Cart] current user cart
  def current_cart
    @current_cart ||= Cart.find_by(token: session[:cart_token]) || create_cart
  end

  # Destroys old cart and creates a new one
  # @return [Cart] new cart
  def reset_current_cart
    current_cart.destroy
    @current_cart = create_cart
  end

  # Renders link to add item to the cart if items quantity is greater than 0.
  # Otherwise it renders button with 'no items' caption.
  # @param item [Item] item that should be added to cart
  # @return [String] correct link element
  def link_to_add_to_cart(item)
    if item.could_be_ordered?
      link_to I18n.t('cart.add_to_cart'), add_to_cart_path(item), method: :post, remote: true, class: 'btn btn-orn js-thanks'
    else
      link_to I18n.t('cart.not_available'), '#', remote: true, class: 'btn btn-orn'
    end
  end

  private

    # Creates new cart and writes its token to cookies
    # @return [Cart] new cart
    def create_cart
      cart = Cart.create
      session[:cart_token] = cart.token
      cart
    end
end
