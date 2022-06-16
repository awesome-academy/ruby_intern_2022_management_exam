module SessionsHelper
  def current_user? user
    user && user == @current_user
  end

  def is_admin?
    return unless user_signed_in?

    current_user.admin?
  end
end
