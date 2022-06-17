class AdminController < ApplicationController
  layout "admin"
  authorize_resource class: false
end
