class AdminController < ApplicationController
  layout "admin"
  before_action :admin_user
end
