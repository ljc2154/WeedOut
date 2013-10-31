class Course < ActiveRecord::Base
  	belongs_to :professor, class_name: "User"
  	has_many :questions
  	scope :with_questions, -> { where('id IN (SELECT DISTINCT(course_id) FROM questions)')}
  	scope :without_questions, -> { where('id NOT IN (SELECT DISTINCT(course_id) FROM questions)')}

	def self.search(search)
		  if search 
		  	begin 
		  	   Float(search)
			   where("call_number = '#{search}'")
			rescue
				Course.all
			end
		  else
		    Course.all
		  end
	end

end
