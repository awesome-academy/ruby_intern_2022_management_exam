class ExamsController < ApplicationController
  before_action :logged_in_user

  def index
    @exams = current_user.exams
  end
end
