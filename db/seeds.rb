30.times do |n|
  exam_id = rand 1..5
  quest_id = rand 1..66
  ExamQuestion.create!(exam_id: exam_id,
                      question_id: quest_id,
                      created_at: Time.now,
                      updated_at: Time.now
                      )
end

User.create!(name: "Khang",
  email: "khangt893@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 1,
  activated: true,
  activated_at: Time.zone.now)

User.create!(name: "Son",
  email: "sontran@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: 0,
  activated: true,
  activated_at: Time.zone.now)
