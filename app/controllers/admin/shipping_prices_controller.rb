class Admin::ShippingPricesController < Admin::ApplicationController
  before_action { authorize! :manage, ShippingMethod }
  before_action :set_shipping_method

  # POST /admin/shipping_methods/:shipping_method_id/shipping_prices
  def create
    @shipping_method.shipping_prices.create(shipping_method_params)
    redirect_to edit_admin_shipping_method_path(@shipping_method)
  end

  # DELETE /admin/shipping_methods/:shipping_method_id/shipping_prices/:id
  def destroy
    @shipping_price = ShippingPrice.find(params[:id])
    @shipping_price.destroy
    redirect_to edit_admin_shipping_method_path(@shipping_method)
  end

  private

    def set_shipping_method
      @shipping_method = ShippingMethod.find(params[:shipping_method_id])
    end

    def shipping_method_params
      params.require(:shipping_price).permit(:city_id, :price)
    end
end
