class RecordsController < ApplicationController
  before_action :authenticate_user!, only: %i(create)
  authorize_resource

  def create
    if params[:record].present?
      options = params[:record].values.flatten
      user_id = current_user.id
      exam_id = params[:exam_id]
      columns = [:user_id, :exam_id, :option_id]
      values = options.map{|option| [user_id, exam_id, option]}
      import_record columns, values
    else
      score_result
      flash[:success] = t ".submit_success"
    end
    redirect_to exams_path
  end

  private

  def score_result
    records = current_user.records.by_exam_id params[:exam_id]
    score = 0
    question_ids = []
    records.each do |r|
      question_id = r.option.question_id
      if question_ids.exclude?(question_id) && r.option.status == true
        score += 1
        question_ids.push(question_id)
      end
    end
    Result.create user_id: current_user.id,
                  exam_id: params[:exam_id],
                  score: score
  end

  def import_record columns, values
    if Record.import columns, values
      score_result
      flash[:success] = t ".submit_success"
    else
      flash[:danger] = t ".submit_fail"
    end
  end
end
