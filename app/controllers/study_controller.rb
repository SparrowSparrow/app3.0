class StudyController < ApplicationController

    def index
      @universities = University.all
      # debugger
    end

    def show_university
      @universities = University.find(params[:id])
    end

    def new_university
      @universities = University.new
    end

end