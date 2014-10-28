module CartsHelper

  # @return [Cart] current user cart
  def current_cart
    @current_cart ||= Cart.find_by(token: session[:cart_token]) || create_cart
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
