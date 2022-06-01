class AddDurationToSubjects < ActiveRecord::Migration[6.0]
  def change
    add_column :subjects, :duration, :integer
  end
end
