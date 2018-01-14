class ItemsController < ApplicationController
  before_filter :find_item, only: %w(show)
  before_filter :new_review, only: %w(show)

  # GET /items
  def index
    @items = Item.not_deleted.order(position: :asc)
    @items = @items.tagged_with(params[:tag]) if params[:tag].present?
    @page = Page.find_by(slug: 'products')
    set_tags
    set_quantities_by_tag
    render layout: 'item'
  end

  # GET /items/:id
  def show
    render layout: 'item'
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def new_review
    review_params = cookies[:not_created_review].present? ? ActiveSupport::JSON.decode(cookies[:not_created_review]) : {}
    if user_signed_in?
      @review = current_user.reviews.build(review_params.merge({name: current_user.name, email: current_user.email, item_ids: [@item.try(:id)].select(&:present?)}))
    else
      @review = Review.new(review_params.merge({item_ids: [@item.try(:id)].select(&:present?)}))
    end
  end

  def set_quantities_by_tag
    @total_quantity = Item.not_deleted.count
    @quantities_by_tag = {}
    @tags.each do |tag|
      count = Item.not_deleted.tagged_with(tag.name).count
      @quantities_by_tag[tag] = count if count > 0
    end
  end
end
