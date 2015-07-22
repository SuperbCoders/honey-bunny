class Review < ActiveRecord::Base
  PLACES = %w(index item both)

  include Workflow

  workflow do
    state :new do
      event :approve, transitions_to: :approved
      event :decline, transitions_to: :declined
    end
    state :approved do
      event :decline, transitions_to: :declined
    end
    state :declined do
      event :approve, transitions_to: :approved
    end
  end

  belongs_to :user
  has_and_belongs_to_many :items

  validates :user, presence: true
  validates :name, presence: true
  validates :email, presence: true, format: { with: /([\.A-Za-z0-9_-]+@[\.A-Za-z0-9_-]+\.[A-Za-z]{2,})+/ }
  #validates :city, presence: true
  validates :message, presence: true
  validates :place, presence: true, inclusion: { in: PLACES }
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  before_validation :set_default_values
  after_commit :notify_about_review

  private

  def set_default_values
    self.place ||= items.any? ? 'item' : 'index'
  end

  def notify_about_review
    User.admins.notify_about_questions.each do |admin|
      ReviewMailer.notify_admin(id, admin.email).deliver! if admin.email.present?
    end
  end
end
