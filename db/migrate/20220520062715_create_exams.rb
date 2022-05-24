class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :finish_time

      t.timestamps
    end
  end
end
