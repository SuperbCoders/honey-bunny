class ApplicationController < ActionController::Base
  include CartsHelper
  protect_from_forgery with: :exception

  helper_method :mobile_device?

  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
end
