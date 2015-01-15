# Helper for page meta data generation and rendering
module MetaHelper

  # Renders title tag
  # @param value [String] custom title (optional)
  # @return [String] title tag
  def title_tag(value = nil)
    content_tag :title do
      value || page_title
    end
  end

  # Renders meta tags depending on current page meta data
  # @return [ActiveSupport::SafeBuffer] meta tags
  def meta_tags
    page_meta.to_meta_tag_options(request.host).map do |key, value|
      tag :meta, name: key, content: value
    end.join.html_safe
  end

  # Renders additional javascript
  # @return [ActiveSupport::SafeBuffer] meta tags
  def javascript_block
    page_meta.javascript.to_s.html_safe
  end

  private

    # Returns title for the current page
    # @return [String] title for the current page
    def page_title
      page_meta.title.present? ? page_meta.title : default_meta.title
    end

    # Tries to retrieve meta data for current context
    # or returns default meta data if nothing else was found
    # @return [MetaBlock] page meta data
    def page_meta
      @page_meta ||= @page.try(:meta_block) || default_meta
    end

    # @return [MetaBlock] default meta data, use it if nothing else was found
    def default_meta
      MetaBlock.new title: 'Honey Bunny',
                    description: '',
                    keywords: '',
                    fb_title: 'Honey Bunny',
                    fb_description: ''
    end
end
