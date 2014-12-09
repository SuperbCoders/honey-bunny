class UpdateSuperbTextConstructor < ActiveRecord::Migration

  module Uploaders
    class GalleryColumnImageUploader < ::BlockImageUploader
      def store_dir
        "uploads/superb_text_constructor/gallery_column_image/image/#{model.id}"
      end
    end

    class GallerySlideshowImageUploader < ::BlockImageUploader
      def store_dir
        "uploads/superb_text_constructor/gallery_slideshow_image/image/#{model.id}"
      end
    end

    class ItemElementsListElementUploader < ::BlockElementUploader
      def store_dir
        "uploads/superb_text_constructor/item_elements_list_element/image/#{model.id}"
      end
    end
  end

  module SuperbTextConstructor
    class GalleryColumnImage < ::ActiveRecord::Base
      self.table_name = "superb_text_constructor_blocks"
      self.inheritance_column = :_type_disabled
      serialize :data, Hash
      mount_uploader :image, Uploaders::GalleryColumnImageUploader, serialize_to: :data
    end

    class GallerySlideshowImage < ::ActiveRecord::Base
      self.table_name = "superb_text_constructor_blocks"
      self.inheritance_column = :_type_disabled
      serialize :data, Hash
      mount_uploader :image, Uploaders::GallerySlideshowImageUploader, serialize_to: :data
    end

    class ItemElementsListElement < ::ActiveRecord::Base
      self.table_name = "superb_text_constructor_blocks"
      self.inheritance_column = :_type_disabled
      serialize :data, Hash
      mount_uploader :image, Uploaders::ItemElementsListElementUploader, serialize_to: :data
    end

    class ItemChartBar < ::ActiveRecord::Base
      self.table_name = "superb_text_constructor_blocks"
      self.inheritance_column = :_type_disabled
      serialize :data, Hash
    end
  end

  def up
    remove_index :blocks, [:blockable_type, :blockable_id]

    rename_table :blocks, :superb_text_constructor_blocks
    rename_column :superb_text_constructor_blocks, :template, :type

    add_index :superb_text_constructor_blocks, :type, name: 'superb_text_constructor_blocks_type_index'
    add_index :superb_text_constructor_blocks, [:blockable_type, :blockable_id], name: 'superb_text_constructor_blocks_blockable_index'

    rename_by_camelize('big')
    rename_by_camelize('page_block')
    rename_by_camelize('separator')
    rename_by_camelize('social_panel')
    rename_by_camelize('reviews')
    rename_by_camelize('shops')
    rename_by_camelize('item_feature')
    rename('item_block_2_columns', 'item_2_columns_block')

    # GalleryColumn
    rename('gallery_columns', 'GalleryColumn')
    blocks = execute("SELECT id FROM superb_text_constructor_blocks WHERE type = 'SuperbTextConstructor::GalleryColumn'").to_a
    blocks.each do |block|
      block_images = BlockImage.where(block_id: block['id'])
      block_images.each_with_index do |block_image, index|
        SuperbTextConstructor::GalleryColumnImage.create(blockable_id: block['id'],
                                                         blockable_type: 'SuperbTextConstructor::Block',
                                                         type: 'SuperbTextConstructor::GalleryColumnImage',
                                                         image: File.open("#{Rails.root}/public/#{block_image.image.url}"),
                                                         position: index + 1)
      end
    end

    # GallerySlideshow
    rename_by_camelize('gallery_slideshow')
    blocks = execute("SELECT id FROM superb_text_constructor_blocks WHERE type = 'SuperbTextConstructor::GallerySlideshow'").to_a
    blocks.each do |block|
      block_images = BlockImage.where(block_id: block['id'])
      block_images.each_with_index do |block_image, index|
        SuperbTextConstructor::GallerySlideshowImage.create(blockable_id: block['id'],
                                                         blockable_type: 'SuperbTextConstructor::Block',
                                                         type: 'SuperbTextConstructor::GallerySlideshowImage',
                                                         image: File.open("#{Rails.root}/public/#{block_image.image.url}"),
                                                         position: index + 1)
      end
    end
    drop_table :block_images

    # ItemElementsList
    rename('item_elements', 'ItemElementsList')
    blocks = execute("SELECT id FROM superb_text_constructor_blocks WHERE type = 'SuperbTextConstructor::ItemElementsList'").to_a
    blocks.each do |block|
      elements = BlockElement.where(block_id: block['id'])
      elements.each_with_index do |element, index|
        el = SuperbTextConstructor::ItemElementsListElement.new(blockable_id: block['id'],
                                                                  blockable_type: 'SuperbTextConstructor::Block',
                                                                  type: 'SuperbTextConstructor::ItemElementsListElement',
                                                                  image: File.open("#{Rails.root}/public/#{element.image.url}"),
                                                                  position: index + 1)
        el.data['title'] = element.title
        el.data['text'] = element.text
        el.save!
      end
    end
    drop_table :block_elements

    # ItemChart
    rename_by_camelize('item_chart')
    blocks = execute("SELECT id FROM superb_text_constructor_blocks WHERE type = 'SuperbTextConstructor::ItemChart'").to_a
    blocks.each do |block|
      bars = BlockChart.where(block_id: block['id'])
      bars.each_with_index do |bar, index|
        new_bar = SuperbTextConstructor::ItemChartBar.new(blockable_id: block['id'],
                                                            blockable_type: 'SuperbTextConstructor::Block',
                                                            type: 'SuperbTextConstructor::ItemChartBar',
                                                            position: index + 1)
        new_bar.data['value'] = bar.value
        new_bar.data['title'] = bar.title
        new_bar.data['color'] = bar.color
        new_bar.data['inverse_font_color'] = bar.inverse_font_color
        new_bar.save!
      end
    end
    drop_table :block_charts

    # Items list
    rename('items', 'ItemsList')
    blocks = execute("SELECT id FROM superb_text_constructor_blocks WHERE type = 'SuperbTextConstructor::ItemsList'").to_a
    blocks.each do |block|
      item_ids = execute("SELECT id FROM blocks_items WHERE block_id = '#{block['id']}'").to_a.map do |item|
        item['id']
      end
      block.item_ids = item_ids
      block.save!
    end
    %x(cp -R #{Rails.root}/public/uploads/update_superb_text_constructor/* #{Rails.root}/public/uploads)
    drop_table :blocks_items
  end

  def down
    remove_index :superb_text_constructor_blocks, name: 'superb_text_constructor_blocks_blockable_index'
    remove_index :superb_text_constructor_blocks, name: 'superb_text_constructor_blocks_type_index'    

    rename_column :superb_text_constructor_blocks, :type, :template
    rename_table :superb_text_constructor_blocks, :blocks

    add_index :blocks, [:blockable_type, :blockable_id]
  end

  private

    def rename_by_camelize(name)
      execute "UPDATE superb_text_constructor_blocks SET type = 'SuperbTextConstructor::#{name.camelize}' WHERE type = '#{name}'"
    end

    def rename(old_name, new_name)
      execute "UPDATE superb_text_constructor_blocks SET type = 'SuperbTextConstructor::#{new_name.camelize}' WHERE type = '#{old_name}'"
    end
end
