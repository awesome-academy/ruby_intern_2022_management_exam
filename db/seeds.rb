1.times do |n|
  name = Faker::ProgrammingLanguage.name
  duration = rand 20..30
  Subject.create!(name: name,
                  duration: duration
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
