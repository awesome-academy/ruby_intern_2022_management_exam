class Admin::AdminPageController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :admin_user

  def home; end
end
