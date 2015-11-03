class Admin::UserEmailsController < Admin::ApplicationController
  load_and_authorize_resource param_method: :email_params

  def index
    respond_to do |format|
      format.html
      format.csv { send_data @user_emails.to_csv, filename: "emails-#{Date.today}.csv" }
    end
  end

  def destroy
    if @user_email.destroy!
      redirect_to admin_user_emails_url, notice: I18n.t('shared.destroyed')
    else
      redirect_to admin_user_emails_url, alert: I18n.t('shared.not_destroyed')
    end
  end

  private

  def email_params
    params.require(:user_email).permit(:email)
  end
end
