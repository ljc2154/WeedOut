class TestController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
    if !@course then redirect_to professor_courses_path end
    if @course.questions.count > 0 then
      redirect_to professor_courses_path,
        notice: "Test has already been created for this course"
    end
  end

  def create
    (1..params[:i].to_i).each do |i|
      if (params["questiontext-#{i}"].empty?) then next end
      a = Question.create text: params["questiontext-#{i}"], :course_id => params[:course_id]     
      (1..4).each do |j|
        if (params["questionresponse-#{i}-#{j}"].empty?) then next end
        b = QuestionChoice.create text: params["questionresponse-#{i}-#{j}"], question: a
        if params["questionresponse-#{i}"] == "#{j}" then
          a.correct_choice_id = b.id
          a.save
        end
      end
    end

    redirect_to professor_courses_path, notice: "Your test has been created"
  end

  def getStudentsResponsesForThisCourse uni, course_id
    num_questions = Course.find(course_id).questions.count
    response_list = Array.new(num_questions)
    count = 0
    responses_for_the_uni = Response.where(uni: uni)
    question_ids_for_the_course = Question.where(course_id: course_id).select(:id)
    responses_for_the_uni.each do |one_response|
      #check if the response.question_id is in questions_ids_for_the_course
      question_ids_for_the_course.each do |i|
        if one_response.question_id == i.id then
          response_list[count] = one_response
          count = count + 1
        end
      end
    end
    return response_list
  end

  def show
    @grade_list = Hash.new
    @course = Course.find(params[:course])
    # first check all responses for this course
    questions = Course.find(@course).questions
    num_questions = questions.count
    @first_question = questions.first

    @responses_fq = @first_question.question_responses
    @responses_fq.each do |r|
      u = r.uni
      @grade_list[u] = Array.new(num_questions+1)
      @grade_list[u][num_questions] = 0
      i = 0
      responses_for_this_uni = getStudentsResponsesForThisCourse u, @course
      # responses_for_this_uni = Response.where(uni: u)
      responses_for_this_uni.each do |r_uni|
        if r_uni.question_choice_id == r_uni.question.correct_choice_id then
          @grade_list[u][i] = 1
          @grade_list[u][num_questions] = @grade_list[u][num_questions] + 1
        else
          @grade_list[u][i] = 0
        end
        i = i + 1
      end
    end
  end
end
