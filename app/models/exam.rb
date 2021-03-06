class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  has_one :result, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :exams_questions, dependent: :destroy
  has_many :questions, through: :exams_questions, dependent: :destroy

  delegate :name, :duration, to: :subject, prefix: true, allow_nil: true
  delegate :score, to: :result, prefix: true, allow_nil: true
  after_create :create_exam_question

  scope :sort_by_date, ->{order(created_at: :desc)}

  private

  def create_exam_question
    subject.questions.each do |question|
      exams_questions.create! question_id: question.id
    end
  end
end
