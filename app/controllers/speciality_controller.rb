class SpecialityController < ApplicationController
  def index
    @specialities = Speciality.all

    @skills = EduProgram.joins(:connection_speciality_courses).select('connection_speciality_courses.weight, connection_speciality_courses.id_course, edu_programs.*').where(:connection_speciality_courses => {:id_speciality => params[:id] || 1})
    @current_speciality = Speciality.find(params[:id] || 1)
    # debugger

  end

  def new
  end

  def edit
  end
end

