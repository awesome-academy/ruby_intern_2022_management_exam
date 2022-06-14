class ExamsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_exam, only: %i(show)

  def index
    @exams = current_user.exams
  end

  def show
    @exam_questions = @exam.questions
  end

  def create
    new_exam = current_user.exams.new subject_id: params[:subject_id]
    new_exam.save!
    flash[:success] = t ".suscess_message"
    redirect_to exams_path
  rescue ActiveRecord::ActiveRecordError
    flash.now[:danger] = t ".fail_message"
    redirect_to subjects_path
  end

  private
  def find_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam

    flash[:danger] = t ".no_exam"
    redirect_to root_path
  end
end
