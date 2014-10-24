module BlocksHelper

  # Generate styles for page block in editor depending on its background options
  # @param block [Block]
  # @return [String] styles for block
  def block_background_style(block)
    if block.background_type == 'color' && block.background_color.present?
      "background-color: #{block.background_color}"
      elsif block.background_type == 'background' && block.background?
      "background: url(#{block.background.thumb}); background-size: cover; color: #FFF"
    else nil
    end
  end

end
