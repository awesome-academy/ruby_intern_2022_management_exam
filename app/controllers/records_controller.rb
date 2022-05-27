class RecordsController < ApplicationController
  before_action :logged_in_user, only: %i(create)

  def create
    options = params[:record].values
    user_id = current_user.id
    exam_id = params[:exam_id]
    columns = [:user_id, :exam_id, :option_id]
    values = options.map do |option|
      [user_id, exam_id, option]
    end
    if Record.import columns, values
      score_result
      flash[:success] = t ".submit_success"
    else
      flash[:danger] = t ".submit_fail"
    end
    redirect_to exams_path
  end

  private

  def score_result
    records = current_user.records.by_exam_id params[:exam_id]
    score = 0
    records.each do |r|
      score += 1 if r.option.status == true
    end
    Result.create user_id: current_user.id,
                  exam_id: params[:exam_id],
                  score: score
  end
end
