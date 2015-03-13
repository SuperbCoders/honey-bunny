class Admin::QuestionsController < Admin::ApplicationController
  include WorkflowController
  load_and_authorize_resource
  workflow_events :archive, :restore
  before_action :set_question, only: [:archive, :restore]

  # GET /admin/questions
  def index
    @questions = @questions.order(created_at: :desc)
    @questions = @questions.where(workflow_state: params[:workflow_state].present? ? params[:workflow_state] : 'new')
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

end
