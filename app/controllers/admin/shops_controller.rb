class Admin::ShopsController < Admin::ApplicationController
  load_and_authorize_resource param_method: :shop_params

  # GET /admin/shops
  def index
    @shops = @shops.order(id: :asc)
  end

  # GET /admin/shops/new
  def new
  end

  # POST /admin/shops
  def create
    if @shop.save
      redirect_to admin_shops_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/shops/:id/edit
  def edit
  end

  # PATCH/PUT /admin/shops/:id
  def update
    if @shop.update_attributes(shop_params)
      redirect_to admin_shops_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/shops/:id
  def destroy
    @shop.destroy
    redirect_to admin_shops_url, notice: I18n.t('shared.destroyed')
  end

  private

    def shop_params
      params.require(:shop).permit(:name, :logo, :address, :phone, :email, :lat, :lon, :official)
    end

end
