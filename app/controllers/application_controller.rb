class ApplicationController < ActionController::Base
  before_action :set_locale

  include Pagy::Backend
  include SessionsHelper

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".login_warning"
    redirect_to login_path
  end

  def admin_user
    return if is_admin?

    flash[:danger] = t ".admin_warning"
    redirect_to root_path
  end
end
