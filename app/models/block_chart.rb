class BlockChart < ActiveRecord::Base
  belongs_to :block, inverse_of: :charts
  validates_presence_of :block, :value, :title, :color
end
