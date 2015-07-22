class ReviewMailer < ActionMailer::Base
  default from: "\"Honey Bunny\" <#{Settings::Social.email}>"

  # Send notification about new review to
  def notify_admin(id, email)
    @review = Review.find(id)
    mail to: email
  end
end
