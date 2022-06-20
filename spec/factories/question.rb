FactoryBot.define do
  factory :question do
    subject_id{rand 11..30}
    description{Faker::Artist.name}
    type = 1
  end
end
