class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can %i(read), Subject
      can %i(read create), Exam, user_id: user.id
      can %i(read create), Record, user_id: user.id
    end
  end
end
