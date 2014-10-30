# encoding: utf-8

class UserAvatarUploader < BaseImageUploader

  # Create different versions of your uploaded files:
  version :medium do
    process resize_to_fit: [122, 122]
  end

end
