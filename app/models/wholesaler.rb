class Wholesaler < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable,
  # :registerable, :recoverable, :rememberable
  devise :database_authenticatable, :trackable, :validatable

  has_one :company, as: :member
  accepts_nested_attributes_for :company

  validates :company, presence: true
end
