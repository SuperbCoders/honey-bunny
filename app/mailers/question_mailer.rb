class QuestionMailer < ActionMailer::Base
  default from: "\"Honey Bunny\" <#{Settings::Social.email}>"

  # Send notification about new question to
  def notify_admin(question_id, email)
    @question = Question.find(question_id)
    mail to: email
  end
end
