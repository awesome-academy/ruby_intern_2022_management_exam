class Question < ApplicationRecord
  belongs_to :subject
  has_many :options, dependent: :destroy
  enum question_type: {single_choice: 0, multiple_choice: 1}
end
