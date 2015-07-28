class WholesalerDevise::SessionsController < Devise::SessionsController
  layout 'item'

  protected

  def after_sign_in_path_for(resource)
    new_cabinet_order_url
  end
end
