class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :course_id, :null => false
      t.integer :correct_choice_id

      t.timestamps
    end
  end
end
