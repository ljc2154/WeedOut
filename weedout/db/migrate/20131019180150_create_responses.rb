class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :uni
      t.integer :question_id
      t.integer :question_choice_id

      t.timestamps
    end
  end
end
