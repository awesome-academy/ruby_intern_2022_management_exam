class Subject < ApplicationRecord
  SUBJECT_PARAMS = %i(name duration).freeze
  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  scope :search,
        ->(name){where("name LIKE ?", "%#{name}%") if name.present?}

  validates :name, presence: true,
            length: {maximum: Settings.admin.subjects.name_length},
            uniqueness: true
  validates :duration, presence: true
end
