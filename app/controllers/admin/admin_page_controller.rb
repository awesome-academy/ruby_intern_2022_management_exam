class Admin::AdminPageController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :admin_user

  def home; end
end
