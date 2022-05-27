class Question < ApplicationRecord
  belongs_to :subject
  has_many :options, dependent: :destroy
  has_many :exams_questions, dependent: :destroy
  has_many :exams, through: :exams_questions, dependent: :destroy

  enum question_type: {single_choice: 0, multiple_choice: 1}
end
