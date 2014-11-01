class Admin::ReviewsController < Admin::ApplicationController
  include WorkflowController

  workflow_events :approve, :decline
  load_and_authorize_resource param_method: :review_params

  # GET /admin/reviews
  def index
    workflow_state = params[:workflow_state].present? ? params[:workflow_state] : 'new'
    @reviews = @reviews.where(workflow_state: workflow_state)
    @reviews = @reviews.order(created_at: :desc)
    @reviews = @reviews.page(params[:page]).per(25)
  end

  # GET /admin/reviews/new
  def new
  end

  # POST /admin/reviews
  def create
    if @review.save
      redirect_to admin_reviews_url(workflow_state: @review.workflow_state), notice: I18n.t('shared.saved')
    else
      render 'new'
    end
  end

  # GET /admin/reviews/new/:id/edit
  def edit
  end

  # PATCH/PUT /admin/reviews/:id
  def update
    if @review.update_attributes(review_params)
      redirect_to admin_reviews_url(workflow_state: @review.workflow_state), notice: I18n.t('shared.saved')
    else
      render 'edit'
    end
  end

  # DELETE /admin/reviews/:id
  def destroy
    if @review.destroy
      redirect_to admin_reviews_url(workflow_state: @review.workflow_state), notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_reviews_url(workflow_state: @review.workflow_state), alert: I18n.t('shared.not_destroyed')
    end
  end

  private

    def review_params
      params.require(:review).permit(:name, :email, :city, :rating, :message, :place, item_ids: [])
    end
end
