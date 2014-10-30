# encoding: utf-8

class ShopLogoUploader < BaseImageUploader

  # Create different versions of your uploaded files:
  version :full do
    process resize_to_fit: [65, 65]
  end

end
