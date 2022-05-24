class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :records, dependent: :destroy
  has_many :exams, dependent: :destroy
  has_many :results, dependent: :destroy
end
