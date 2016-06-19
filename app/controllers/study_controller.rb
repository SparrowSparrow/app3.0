class StudyController < ApplicationController

    def index
      @universities = University.all
      @edu_programs = EduProgram.joins(:connection_university_courses).where(:connection_university_courses => {:id_university => params[:id] || 1})
      @current_university = University.find(params[:id] || 1)
      # debugger
    end

    def show_university
      @universities = University.find(params[:id])
    end

    def new_university
      @universities = University.new
    end

end