class WelcomeController < ApplicationController
  layout 'welcome'

  # GET /
  def index
    @items = Item.not_deleted.order(position: :asc)
    @page = Page.find_by(slug: 'index')
  end
end
