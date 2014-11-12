class ItemsController < ApplicationController

  # GET /items
  def index
    @items = Item.order(created_at: :desc)
    @items = @items.tagged_with(params[:tag]) if params[:tag].present?
    @page = Page.find_by(slug: 'products')
    set_tags
    set_quantities_by_tag
  end

  # GET /items/:id
  def show
    @item = Item.find(params[:id])
    render layout: 'item'
  end

  private

    def set_tags
      @tags = ActsAsTaggableOn::Tag.most_used
    end

    def set_quantities_by_tag
      @total_quantity = Item.count
      @quantities_by_tag = {}
      @tags.each do |tag|
        count = Item.tagged_with(tag.name).count
        @quantities_by_tag[tag] = count if count > 0
      end
    end

end
