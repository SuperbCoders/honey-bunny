class WelcomeController < ApplicationController
  layout 'welcome'

  # GET /
  def index
    @items = Item.all
    @page = Page.find_by(slug: 'index')
  end
end
