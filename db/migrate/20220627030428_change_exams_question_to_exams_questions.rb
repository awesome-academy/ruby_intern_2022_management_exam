class ChangeExamsQuestionToExamsQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_table :exams_question, :exams_questions
  end
end
