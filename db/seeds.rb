# 30.times do |n|
#   name = Faker::ProgrammingLanguage.name
#   duration = rand 20..30
#   Subject.create!(name: name,
#                   duration: duration
#                  )
# end

User.create!(name: "ADMIN",
  email: "hoanganhduong3010@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  role: 1)

User.create!(name: "Hoang Anh",
  email: "duong.hoang.anh@sun-asterisk.com",
  password: "123123",
  password_confirmation: "123123",
  role: 0)

99.times do |n|
  name = "Account" + "#{n}"
  email = "example-#{n+1}@gmail.com"
  User.create!(name: name,
              email: email,
              role: 0,
              password: "123123",
              password_confirmation: "123123")
end
