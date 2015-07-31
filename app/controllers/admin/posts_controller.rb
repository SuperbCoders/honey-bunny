class Admin::PostsController < Admin::ApplicationController
  load_and_authorize_resource param_method: :post_params
  before_action :build_meta_block, only: [:new, :create, :edit, :update]

  # GET /admin/pages
  def index
  end

  # GET /admin/pages/new
  def new
  end

  # POST /admin/pages
  def create
    if @post.save
      redirect_to admin_posts_url, notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/pages/:id/edit
  def edit
  end

  # PUT/PATCH /admin/pages/:id
  def update
    if @post.update_attributes(post_params)
      # Fix broken CarrierWave remove_image behavior
      @post.meta_block.remove_fb_image! if params[:post][:meta_block_attributes][:remove_fb_image].present?
      redirect_to admin_posts_url, notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/pages:/id
  def destroy
    if @post.destroy!
      redirect_to admin_posts_url, notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_posts_url, alert: I18n.t('shared.not_destroyed')
    end
  end

  private

  def post_params
    allowed_params = [:title, :slug, :description, :subtitle, :cover, :dark_cover, :tag_list, :published ,{ meta_block_attributes: [:id, :title, :description, :keywords, :javascript, :fb_image, :remove_fb_image, :fb_title, :fb_description] }]
    params.require(:post).permit(allowed_params)
  end

  def build_meta_block
    @post.build_meta_block if @post.meta_block.nil?
  end
end
