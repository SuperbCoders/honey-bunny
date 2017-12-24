class WelcomeController < ApplicationController
  layout 'welcome'

  # GET /
  def index
    @items = Item.not_deleted.order(updated_at: :desc)
    @page = Page.find_by(slug: 'index')
  end
end
