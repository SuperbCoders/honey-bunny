class Admin::QuestionsController < Admin::ApplicationController
  load_and_authorize_resource

  # GET /admin/questions
  def index
    @questions = @questions.order(created_at: :desc)
  end

end
