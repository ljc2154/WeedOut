class CreateQuestionChoices < ActiveRecord::Migration
  def change
    create_table :question_choices do |t|
      t.string :text
      t.integer :question_id, :null => false

      t.timestamps
    end
  end
end
