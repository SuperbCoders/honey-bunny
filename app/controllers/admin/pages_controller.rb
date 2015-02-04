class Admin::PagesController < Admin::ApplicationController
  load_and_authorize_resource param_method: :page_params
  before_action :build_meta_block, only: [:new, :create, :edit, :update]

  # GET /admin/pages
  def index
  end

  # GET /admin/pages/new
  def new
  end

  # POST /admin/pages
  def create
    if @page.save
      redirect_to admin_pages_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/pages/:id/edit
  def edit
  end

  # PUT/PATCH /admin/pages/:id
  def update
    if @page.update_attributes(page_params)
      redirect_to admin_pages_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/pages:/id
  def destroy
    if @page.destroyable? && @page.destroy!
      redirect_to admin_pages_url, notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_pages_url, alert: I18n.t('shared.not_destroyed')
    end
  end

  private

    def page_params
      allowed_params = [:slug, :title, :motto, :subtitle, :cover, :dark_cover, :shadow_cover, { meta_block_attributes: [:id, :title, :description, :keywords, :javascript, :fb_image, :remove_fb_image, :fb_title, :fb_description] }]
      allowed_params << :published unless @page.try(:system?)
      params.require(:page).permit(allowed_params)
    end

    def build_meta_block
      @page.build_meta_block if @page.meta_block.nil?
    end
end
