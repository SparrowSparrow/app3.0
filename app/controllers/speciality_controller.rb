class SpecialityController < ApplicationController
  def index
    @specialities = Speciality.all
    # @skills = EduProgram.joins(:connection_speciality_courses).select('edu_programs.*, connection_speciality_course.*').where(:connection_speciality_courses => {:id_speciality => params[:id] || 1})
    # debugger
    @skills = EduProgram.joins(:connection_speciality_courses).select('connection_speciality_courses.weight,edu_programs.*').where(:connection_speciality_courses => {:id_speciality => params[:id] || 1})
    @current_speciality = Speciality.find(params[:id] || 1)
    # @skills_weight = ConnectionUniversityCourse.select(:weight)
    # @p = ActiveRecord::Base.connection.execute("SELECT * FROM edu_programs JOIN connection_speciality_courses ON edu_program.id = connection_speciality_courses.id_speciality")
    # debugger
  end

  def new
  end

  def edit
  end
end

