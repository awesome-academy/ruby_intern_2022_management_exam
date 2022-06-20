FactoryBot.define do
  factory :subject do
    name{Faker::Beer.brand}
    duration{rand 20..30}
  end
end
