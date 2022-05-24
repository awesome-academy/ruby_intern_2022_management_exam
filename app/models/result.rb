class Result < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  enum status: {failed: 0, passed: 1, pending: 2}
end
