class ExamsController < ApplicationController
  before_action :logged_in_user
  before_action :find_exam, only: %i(show)

  def index
    @exams = current_user.exams
  end

  def show
    @exam_questions = @exam.questions
  end

  private
  def find_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end
end
