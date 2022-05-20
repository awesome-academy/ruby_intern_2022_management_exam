class Option < ApplicationRecord
  belongs_to :question
  has_many :records, dependent: :destroy
end
