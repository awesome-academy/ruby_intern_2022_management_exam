class SessionsController < ApplicationController
  before_action :find_by_email, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      log_in @user
      params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
      redirect_to root_path
    else
      flash[:danger] = t ".no_user"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def find_by_email
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash[:danger] = t ".find_error"
  end
end
