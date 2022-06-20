module ExamHelper
  def spent_time finish, start
    time = finish.to_i - start.to_i
    "#{time / 60} m #{time % 60} s"
  end
end
