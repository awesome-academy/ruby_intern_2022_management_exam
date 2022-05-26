class Subject < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  scope :search,
        ->(search){where("name LIKE ?", "%#{search}%") if search.present?}
end
