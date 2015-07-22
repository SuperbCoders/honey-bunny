class ReviewsController < ApplicationController
  before_action :authenticate_user!

  # POST /reviews
  def create
    @review = current_user.reviews.create(review_params)
  end

  private

  def review_params
    params.require(:review).permit(:name, :email, :city, :message, :rating, item_ids: [])
  end
end
