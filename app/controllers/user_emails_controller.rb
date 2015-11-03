class UserEmailsController < ApplicationController
  def create
    @email_subscription = UserEmail.create(email_params)
  end

  private

  def email_params
    params.require(:user_email).permit(:email)
  end
end
