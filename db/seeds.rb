30.times do |n|
  name = Faker::ProgrammingLanguage.name
  Subject.create!(name: name,
                  duration: 30
                 )
end

5.times do |n|
  id = 1
  subject_id = rand 8
  now = Time.now
  a_day_ago = now - 60 * 60 * 24
  random_time = rand a_day_ago..now
  Exam.create!(user_id: id,
               subject_id: subject_id,
               start_time: now,
               finish_time: random_time,
              )
end
