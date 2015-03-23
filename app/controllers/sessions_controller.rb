class SessionsController < Devise::SessionsController
  layout 'login'

  # GET /resource/sign_in
  def new
    cookies[:omniauth_redirect_url] = admin_root_url
    super
  end

end