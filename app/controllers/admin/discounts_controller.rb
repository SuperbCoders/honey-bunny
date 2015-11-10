class Admin::DiscountsController < Admin::ApplicationController
  load_and_authorize_resource param_method: :discount_params

  def index
  end

  def new
  end

  def create
    if @discount.save
      redirect_to admin_discounts_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @discount.update_attributes(discount_params)
      redirect_to admin_discounts_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  def destroy
    if @discount.destroy!
      redirect_to admin_discounts_url, notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_discounts_url, alert: I18n.t('shared.not_destroyed')
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:code, :amount, :kind, :mode, :active)
  end
end
