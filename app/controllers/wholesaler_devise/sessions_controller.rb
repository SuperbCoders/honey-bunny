class WholesalerDevise::SessionsController < Devise::SessionsController
  layout 'item'

  protected

  def after_sign_in_path_for(resource)
    cabinet_orders_url
  end
end
