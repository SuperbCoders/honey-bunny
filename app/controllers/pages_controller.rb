class PagesController < ApplicationController

  # GET /info/:id
  def show
    @page = Page.published.find_by!(slug: params[:id])
    @blocks = @page.blocks
  end

  # GET /info/company
  def company
    @page = Page.find_by!(slug: 'company')
  end

  # GET /info/cosmetics
  def cosmetics
    @page = Page.find_by!(slug: 'cosmetics')
  end
end
