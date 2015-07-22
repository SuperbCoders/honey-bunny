class ItemReviewsController < ApplicationController
  before_filter :find_parent, only: %w(create)

  def create
    if user_signed_in?
      from_cookie = cookies[:not_created_review].present? ? ActiveSupport::JSON.decode(cookies[:not_created_review]) : {}
      @review = current_user.reviews.new({email: current_user.email, name: current_user.name}.merge(review_params).merge(from_cookie))
      @review.items << @parent
      current_user.update_attributes(email: @review.try(:email)) unless current_user.email

      if @review.save
        cookies.delete(:not_created_review)
      end
    else
      @review = Review.new
      cookies[:omniauth_redirect_url] = item_path(@parent)
      cookies.permanent[:not_created_review] = ActiveSupport::JSON.encode(review_params)
    end
  end

  private

  def find_parent
    @parent = Item.find(params[:item_id])
  end

  def review_params
    params.require(:review).permit(:name, :email, :city, :message, :rating)
  end
end
