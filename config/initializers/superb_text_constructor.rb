SuperbTextConstructor.configure do |config|
  config.configs_path = "#{Rails.root}/config/superb_text_constructor.yml"

  config.default_namespace = 'pages'

  config.additional_permitted_attributes = {
    images_attributes: [:id, :image, :_destroy],
    elements_attributes: [:id, :title, :text, :image, :_destroy],
    charts_attributes: [:id, :value, :title, :color, :inverse_font_color, :_destroy],
    item_ids: []
  }
end
