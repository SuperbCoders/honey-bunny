# encoding: utf-8

class ItemMainImageUploader < BaseUploader

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

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end

end
