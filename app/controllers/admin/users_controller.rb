class Admin::UsersController < AdminController
  def index
    @search = User.ransack(params[:search])
    @pagy, @users = pagy @search.result,
                         items: Settings.admin.list_item
    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user&.destroy
      flash[:success] = t ".message_success"
      respond_to do |format|
        format.js
        format.html
      end
    else
      flash[:danger] = t ".messgae_fail"
      redirect_to admin_users_path
    end
  end
end
