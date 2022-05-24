class Exam < ApplicationRecord
  belongs_to :user
  has_one :result, dependent: :destroy
  has_many :records, dependent: :destroy
  has_many :questions, through: :subjects
end
