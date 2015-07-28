# encoding: utf-8
class MaterialUploader < BaseImageUploader

  storage :file

  def extension_white_list
    %w(txt doc docx pdf xls xlsx html rar zip psd gif png jpg svg)
  end

end
