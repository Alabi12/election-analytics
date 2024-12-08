class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (not logged in)

    if user.role == 'admin'
      can :manage, :all
    elsif user.role == 'party_agent'
      can :manage, Vote
    else
      # Default permissions for other roles (or guest users)
      can :read, :all
    end
  end
end
