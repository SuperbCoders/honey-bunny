class SetDefaultFAQPositions < ActiveRecord::Migration
  def up
    FAQ.all.each_with_index do |faq, index|
      faq.update_attributes(position: index + 1)
    end
  end

  def down
  end
end
