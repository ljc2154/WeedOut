class HomeController < ApplicationController
  before_filter :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index]

  def index
  	if user_signed_in? && current_user.isprofessor == true
  		redirect_to professor_courses_path
  	elsif user_signed_in?
  		redirect_to courses_path
  	end 
  end
end
