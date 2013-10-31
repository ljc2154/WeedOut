class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :department_code
      t.integer :call_number
      t.string :term
      t.string :section_full
      t.string :course_title
      t.text :description
      t.integer :num_fixed_units
      t.string :room
      t.string :building_1
      t.timestamps
    end
  end
end
