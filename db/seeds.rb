30.times do |n|
  exam_id = rand 1..5
  quest_id = rand 1..66
  ExamQuestion.create!(exam_id: exam_id,
                      question_id: quest_id,
                      created_at: Time.now,
                      updated_at: Time.now
                      )
end

User.create!(name: "ADMIN",
  email: "hoanganhduong3010@gmail.com",
  password: "123123",
  password_confirmation: "123123",
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

99.times do |n|
  name = "Account" + "#{n}"
  email = "example-#{n+1}@gmail.com"
  User.create!(name: name,
              email: email,
              role: 0,
              password: "123123",
              activated: true,
              activated_at: Time.zone.now,
              password_confirmation: "123123")
end
