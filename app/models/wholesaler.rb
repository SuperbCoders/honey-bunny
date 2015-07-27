class Wholesaler < ActiveRecord::Base
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

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable,
  # :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :trackable, :validatable, :rememberable, :recoverable

  has_one :company, as: :member
  accepts_nested_attributes_for :company

  has_many :wholesale_orders

  validates :company, presence: true

  private

    def approve
      WholesalerMailer.approved(id).deliver!
    end
end
