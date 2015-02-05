class Admin::SettingsController < Admin::ApplicationController
  before_action { authorize! :manage, ShippingMethod }
  before_action :set_shipping_method, only: [:edit, :update]

  # GET /admin/settings
  def index
    @meta_block = MetaBlock.default
  end

  # PATCH /admin/update_meta_block
  def update_meta_block
    @meta_block = MetaBlock.default
    if @meta_block.update_attributes(meta_block_params)
      redirect_to admin_settings_url, notice: I18n.t('shared.saved')
    else
      redirect_to admin_settings_url, alert: I18n.t('shared.not_saved')
    end
  end

  private

    def meta_block_params
      params.require(:meta_block).permit(:title, :description, :keywords, :javascript, :fb_image, :remove_fb_image, :fb_title, :fb_description)
    end
end
