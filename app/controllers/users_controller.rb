class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t ".show_error"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_parmas
    if @user.save
      log_in @user
      flash.now[:success] = t ".wellcome"
      redirect_to @user
    else
      flash.now[:danger] = t ".error_message"
      render :new
    end
  end

  private
  def user_parmas
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
