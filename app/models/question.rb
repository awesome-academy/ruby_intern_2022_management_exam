class Question < ApplicationRecord
  QUESTION_PARAMS = [:subject_id,
                     :description,
                     :question_type,
                     options_attributes: [:id,
                                          :question_id,
                                          :status,
                                          :description,
                                          :_destroy]].freeze
  belongs_to :subject
  has_many :options, dependent: :destroy
  has_many :exams_questions, dependent: :destroy
  has_many :exams, through: :exams_questions, dependent: :destroy
  accepts_nested_attributes_for :options,
                                reject_if: :all_blank,
                                allow_destroy: true

  delegate :name, to: :subject, prefix: true, allow_nil: true

  enum question_type: {single_choice: 0, multiple_choice: 1}

  scope :sort_by_date, ->{order(created_at: :desc)}
end
