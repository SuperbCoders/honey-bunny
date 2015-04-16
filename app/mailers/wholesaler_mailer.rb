class WholesalerMailer < ActionMailer::Base
  default from: "\"Honey Bunny\" <#{Settings::Social.email}>"

  # Send notification about new question to
  def notify_admin(wholesaler_id, email)
    @wholesaler = Wholesaler.find(wholesaler_id)
    mail to: email
  end

  def approved(wholesaler_id)
    @wholesaler = Wholesaler.find(wholesaler_id)
    mail to: @wholesaler.email
  end
end
