class ItemsController < ApplicationController

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/:id
  def show
    @item = Item.find(params[:id])
    render layout: 'item'
  end

end
