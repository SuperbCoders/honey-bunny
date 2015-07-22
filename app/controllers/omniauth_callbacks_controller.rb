class OmniauthCallbacksController < SuperbAuth::OmniauthCallbacksController
  protected

    def common_redirect
      url = cookies[:omniauth_redirect_url] || main_app.root_url
      redirect_to url
    end

    def redirect_after_authenticate_with_identity_signed_in
      common_redirect
    end

    def redirect_after_authenticate_with_identity
      common_redirect
    end

    def redirect_after_authenticate_without_identity_signed_id
      common_redirect
    end

    def redirect_after_authenticate_without_identity_success
      common_redirect
    end

    def redirect_after_authenticate_without_identity_failure
      common_redirect
    end

end
