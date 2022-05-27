class ChangeExamQuestionsToExamsQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_table :exam_questions, :exams_question
  end
end
