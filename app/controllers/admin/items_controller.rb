class Admin::ItemsController < Admin::ApplicationController
  before_action { authorize! :manage, Item }
  before_action :set_item, only: [:edit, :update, :destroy, :restore]

  # GET /admin/items
  def index
    @items = Item.order(id: :desc)
    @items = @items.available if params[:state] == 'available'
    @items = @items.deleted if params[:state] == 'deleted'
    @items = @items.page(params[:page]).per(25)
  end

  # GET /admin/items/new
  def new
    @item = Item.new
  end

  # POST /admin/items
  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to admin_items_url
    else
      render 'new'
    end
  end

  # GET /admin/items/:id/edit
  def edit
  end

  # PUT/PATCH /admin/items/:id
  def update
    if @item.update_attributes(item_params)
      redirect_to admin_items_url
    else
      render 'edit'
    end
  end

  # DELETE /admin/items/:id
  def destroy
    if @item.mark_as_deleted
      redirect_to admin_items_url, notice: I18n.t('admin.items.destroy.success')
    else
      redirect_to admin_items_url, alert: I18n.t('admin.items.destroy.fail')
    end
  end

  # PATCH/PUT /admin/items/:id/restore
  def restore
    if @item.restore
      redirect_to admin_items_url, notice: I18n.t('admin.items.restore.success')
    else
      redirect_to admin_items_url, alert: I18n.t('admin.items.restore.fail')
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :main_image, :motto, :volume, :short_description, :price, :wholesale_price, :quantity, :negative_quantity_allowed, :tag_list, :discount)
    end

    def set_item
      @item = Item.find(params[:id])
    end

end
