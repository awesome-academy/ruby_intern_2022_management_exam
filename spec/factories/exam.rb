FactoryBot.define do
  factory :exam do
    subject_id{rand 1..10}
    user_id{rand 1..10}
    created_at{Time.zone.now}
  end
end
