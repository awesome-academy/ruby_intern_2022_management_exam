class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  has_one :result, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :exams_questions, dependent: :destroy
  has_many :questions, through: :exams_questions, dependent: :destroy

  delegate :name, :duration, to: :subject, prefix: true, allow_nil: true
  delegate :score, to: :result, prefix: true, allow_nil: true
  after_save :create_exam_question

  private

  def create_exam_question
    subject.questions.each do |question|
      exams_questions.create! question_id: question.id
    end
  end
end
