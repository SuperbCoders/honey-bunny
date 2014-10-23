class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :access, :admin_panel
      can :manage, :all
    end
  end
end
