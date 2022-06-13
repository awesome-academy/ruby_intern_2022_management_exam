FactoryBot.define do
  factory :subject do
    name{rand 10000..20000}
    duration{rand 20..30}
  end
end
