class QuestionsController < ApplicationController

  # GET /questions
  def index
    @question = Question.new
  end

  # POST /questions
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      User.admins.notify_about_questions.each do |user|
        QuestionMailer.notify_admin(@question.id, user.email).deliver! if user.email.present?
      end
    end
  end

  private

  def question_params
    params.require(:question).permit(:name, :email, :phone, :text)
  end
end
