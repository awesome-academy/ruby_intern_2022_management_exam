class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.references :subject, null: false, foreign_key: true
      t.string :description
      t.integer :question_type, default: 0

      t.timestamps
    end
  end
end
