class Admin::ShippingMethodsController < Admin::ApplicationController
  before_action { authorize! :manage, ShippingMethod }
  before_action :set_shipping_method, only: [:edit, :update]

  # GET /admin/shipping_methods
  def index
    @shipping_methods = ShippingMethod.all
  end

  # GET /admin/shipping_methods/new
  def new
    @shipping_method = ShippingMethod.new
  end

  # POST /admin/shipping_methods
  def create
    @shipping_method = ShippingMethod.new(shipping_method_params)
    if @shipping_method.save
      redirect_to edit_admin_shipping_method_url(@shipping_method), notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/shipping_methods/:id/edit
  def edit
  end

  # PATCH /admin/shipping_methods/:id
  def update
    if @shipping_method.update_attributes(shipping_method_params)
      redirect_to edit_admin_shipping_method_url(@shipping_method), notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  private

    def set_shipping_method
      @shipping_method = ShippingMethod.find(params[:id])
    end

    def shipping_method_params
      params.require(:shipping_method).permit(:name, :title, :rate_type, :rate, :extra_charge)
    end
end
