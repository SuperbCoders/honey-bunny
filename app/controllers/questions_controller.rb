class QuestionsController < ApplicationController

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.save
  end

  private

    def question_params
      params.require(:question).permit(:name, :email, :phone, :text)
    end
end
