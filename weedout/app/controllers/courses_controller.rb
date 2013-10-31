class CoursesController < ApplicationController
	
	require 'open-uri'
	require 'json'
	before_filter :authenticate_user!
	# http://stackoverflow.com/questions/7411577/devise-before-filter-authenticate-admin
	before_filter do
		redirect_to new_user_session_path unless current_user && !current_user.isprofessor
	end

	def edit
  		@course = Course.find(params[:id])
  		# http://stackoverflow.com/questions/5799043/rails-association-how-to-add-the-has-many-object-to-the-owner
  		@course.students.build(params[:current_user])
  		@course.save
	end

	def index
	  @courses = Course.search(params[:search]).with_questions
	  @user = current_user
	end


	def select
	  @prof_name = 'ARCE-FERNANDEZ' #'MARIA I' #
	  m_prof_name = @prof_name.gsub ' ', '%20' 
	  url ='http://data.adicu.com/courses/v2/sections?api_token=b9ac8a50324311e390c312313d000d18&pretty=true&professor='+m_prof_name
	  json_object = JSON.parse(open(url).read())
	  @course_list = json_object["data"]

	end

end
