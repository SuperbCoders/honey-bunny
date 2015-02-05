class OrderMailer < ActionMailer::Base
  default from: "\"Honey Bunny\" <#{Settings::Social.email}>"

  # Send notification about successful order to the customer
  def user_success_email(order_id, email)
    @order = Order.find(order_id)
    mail to: email, subject: I18n.t('order_mailer.user_success_email.subject', order_id: order_id)
  end

  # Send notification about successful order to admin
  def admin_success_email(order_id, email)
    @order = Order.find(order_id)
    mail to: email, subject: I18n.t('order_mailer.admin_success_email.subject', order_id: order_id)
  end
end
