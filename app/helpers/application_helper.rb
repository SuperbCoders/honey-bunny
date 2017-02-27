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

  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end
end
