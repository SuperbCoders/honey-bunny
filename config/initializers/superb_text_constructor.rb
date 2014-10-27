SuperbTextConstructor.configure do |config|
  config.configs_path = "#{Rails.root}/config/superb_text_constructor.yml"

  config.default_namespace = 'pages'

  config.additional_permitted_attributes = {
    images_attributes: [:id, :image, :_destroy]
  }
end
