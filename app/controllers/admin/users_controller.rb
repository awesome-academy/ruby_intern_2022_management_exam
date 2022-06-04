class Admin::UsersController < AdminController
  def index
    @pagy, @users = pagy User.by_name(params[:name])
                             .by_created_at(params[:start_date],
                                            params[:end_date])
                             .by_email(params[:email]),
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
