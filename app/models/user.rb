class User < ActiveRecord::Base
  ROLES = %w(user admin)

  mount_uploader :avatar, UserAvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: %w(facebook vkontakte)
  include SuperbAuth::Concerns::Omniauthable
  include SuperbAuth::Concerns::NonEmailAuthenticable

  oauth_attr :email
  oauth_attr :name
  oauth_attr :avatar, assign_to: :remote_avatar_url, if: -> (user) { !user.avatar? }

  validates :role, presence: true, inclusion: { in: ROLES }

  before_validation :set_default_values

  has_many :reviews, dependent: :restrict_with_error

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
    scope role.pluralize.to_sym, -> { where(role: role) }
  end

  # @return [String] present name that could be displayed
  def display_name
    [name, email, id].select(&:present?).first
  end

  private

    def set_default_values
      self.role ||= 'user'
    end
end
