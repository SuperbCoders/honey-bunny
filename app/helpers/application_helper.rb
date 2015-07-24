module ApplicationHelper
  def resource_name
    :wholesaler
  end

  def resource
    @resource = session[:subscription] || Wholesaler.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:wholesaler]
  end
end
