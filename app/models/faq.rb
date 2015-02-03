class FAQ < ActiveRecord::Base
  validates :question, presence: true
  validates :answer, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 }

  default_scope -> { order(position: :asc) }

  before_validation :set_position

  def first?
    position == 1
  end

  def last?
    position == self.class.max_position
  end

  def up
    return if first?
    previous_object = self.class.unscoped.order(position: :desc).where('position < ?', position).limit(1).first
    previous_position = previous_object.position
    previous_object.update_attributes(position: position)
    update_attributes(position: previous_position)
  end

  def down
    return if last?
    next_object = self.class.where('position > ?', position).limit(1).first
    next_position = next_object.position
    next_object.update_attributes(position: position)
    update_attributes(position: next_position)
  end

  private

    def self.max_position
      unscoped.order(position: :desc).limit(1).pluck(:position).first
    end

    def set_position
      self.position ||=  (self.class.max_position || 0) + 1
    end
end
