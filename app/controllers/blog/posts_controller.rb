class Blog::PostsController < ApplicationController
  before_action :find_resources, only: %w(index)
  before_action :find_resource, only: %w(show)
  layout "blog"

  def index
  end

  def show
    @blocks = @resource.blocks
  end

  private

  def find_resources
    @resources = Post.published.order(id: :asc)
  end

  def find_resource
    @resource = Post.find(params[:id])
  end
end
