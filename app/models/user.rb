class User < ActiveRecord::Base
  ROLES = %w(user admin)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true, inclusion: { in: ROLES }

  before_validation :set_default_values

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end

  private

    def set_default_values
      self.role ||= 'user'
    end
end
