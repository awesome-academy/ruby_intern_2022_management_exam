class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  before_create :update_time

  enum status: {failed: 0, passed: 1, pending: 2}

  private

  def update_time
    Exam.update finish_time: Time.zone.now
  end
end
