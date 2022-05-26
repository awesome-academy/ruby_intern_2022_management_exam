class Subject < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :exams, dependent: :destroy
  scope :search,
        ->(name){where("name LIKE ?", "%#{name}%") if name.present?}
end
