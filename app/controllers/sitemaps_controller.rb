class SitemapsController < ApplicationController
  def show

    @items = Item.not_deleted
    @pages = Page.published
    @posts = Post.published
    respond_to do |format|
      format.xml
    end
  end
end
