class Record < ApplicationRecord
  belongs_to :user
  belongs_to :exam
  belongs_to :option
end
