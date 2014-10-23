class Admin::PagesController < Admin::ApplicationController
  before_action { authorize! :manage, Page }
  before_action :set_page, only: [:edit, :update, :destroy]

  # GET /admin/pages
  def index
    @pages = Page.all
  end

  # GET /admin/pages/new
  def new
    @page = Page.new
  end

  # POST /admin/pages
  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to admin_pages_url
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
      redirect_to admin_pages_url
    else
      render 'edit'
    end
  end

  # DELETE /admin/pages:/id
  def destroy
    @page.destroy if page.destroyable?
    redirect_to admin_pages_url
  end

  private

    def page_params
      params.require(:page).permit(:slug, :title)
    end

    def set_page
      @page = Page.find(params[:id])
    end
end
