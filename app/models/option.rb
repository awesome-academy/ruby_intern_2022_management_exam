class Option < ApplicationRecord
  belongs_to :question
  has_many :records, dependent: :destroy

  validates :description, presence: true
  validates :status, presence: true
end
