class Company < ActiveRecord::Base
  belongs_to :member, polymorphic: true

  validates :name, presence: true
  validates :address, presence: true
  validates :inn, presence: true
  validates :kpp, presence: true
  validates :ogrn, presence: true
  validates :okpo, presence: true
  validates :bank_details, presence: true
end
