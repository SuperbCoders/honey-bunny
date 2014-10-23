class WelcomeController < ApplicationController
  layout 'welcome'

  # GET /
  def index
    @items = Item.all
  end
end
