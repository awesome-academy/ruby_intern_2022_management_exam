class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper
  include SessionsHelper
  include Pagy::Backend

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password,
                   :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

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

  def admin_user
    return if is_admin?

    flash[:danger] = t ".admin_warning"
    redirect_to root_path
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject.present?

    flash[:danger] = t ".not_found"
  end
end
