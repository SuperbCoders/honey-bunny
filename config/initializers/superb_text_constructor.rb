SuperbTextConstructor.configure do

  block :big do
    field :text, partial: :text
  end

  block :page_block do
    field :subtitle
    field :title
    field :text, partial: :text
    field :background_color
    field :background, type: BlockBackgroundUploader, partial: :image
    field :background_type, type: String, partial: :bg_or_color_select
  end

  block :separator
  block :social_panel
  block :reviews
  block :item_reviews
  block :shops

  block :gallery_column do
    nested_blocks :images do
      field :image do
        type BlockImageUploader
        partial :image
        required
      end
    end
  end

  block :gallery_slideshow do
    nested_blocks :images do
      field :image do
        type BlockImageUploader
        partial :image
        required
      end
    end
  end

  block :item_2_columns_block do
    field :title
    field :text, partial: :text
    field :font_size, partial: :font_size_select
  end

  block :item_feature do
    field :title
    field :text, partial: :text
    field :inverse_font_color, type: TrueClass
    field :background, type: BlockBackgroundUploader, partial: :image
  end

  block :item_elements_list do
    field :title
    nested_blocks :elements do
      field :title
      field :text, partial: :text
      field :image, type: BlockElementUploader, partial: :image
    end
  end

  block :item_ingredients do
    field :title
    nested_blocks :elements do
      field :title
      field :text, partial: :text
      field :kind, partial: :item_kind
    end
  end

  block :press_about_us do
    field :title
    nested_blocks :elements do
      field :url
      field :image, type: BlockElementUploader, partial: :image
    end
  end

  block :item_chart do
    field :title
    nested_blocks :bars do
      field :value
      field :title
      field :color
      field :inverse_font_color, type: TrueClass
    end
  end

  block :items_list do
    field :item_ids, type: Array, partial: 'array_of_items'
    def items
      @items ||= Item.where(id: item_ids)
    end
  end

  namespace :pages do
    group :images do
      use :gallery_column
      use :gallery_slideshow
    end
    use :page_block
    use :big
    use :items_list
    use :separator
    use :social_panel
    use :reviews
    use :shops
    use :press_about_us
  end

  namespace :items do
    group :images do
      use :gallery_column
      use :gallery_slideshow
    end
    use :page_block
    use :item_2_columns_block
    use :item_ingredients
    use :item_feature
    use :item_elements_list
    use :press_about_us
    use :item_chart
    use :items_list
    use :separator
    use :social_panel
    #use :reviews
    use :item_reviews
    use :shops
  end

  # namespace :default do
  #   group :headers do
  #     use :h2
  #     use :h3
  #     block :h4 do
  #       field :text
  #     end
  #   end
  #   group :images do
  #     use :image
  #     use :gallery
  #   end
  #   use :text
  #   use :separator
  # end

  # namespace :no_headers do
  #   use :text
  #   use :separator
  #   use :image
  #   use :gallery
  # end

end
