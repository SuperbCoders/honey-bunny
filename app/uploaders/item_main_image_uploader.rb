# encoding: utf-8

class ItemMainImageUploader < BaseImageUploader

  # Create different versions of your uploaded files:
  version :full do
    process :resize_to_fill => [360, 760]
  end

  version :thumb do
    process :resize_to_fill => [200, 420]
  end

  version :thumb_small do
    process :resize_to_fill => [100, 220]
  end

  version :thumb_square do
    process :resize_to_fit => [120, 120]
  end

  version :thumb_square_small do
    process :resize_to_fit => [50, 50]
  end

end
