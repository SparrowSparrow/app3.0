class UniversitiesController < ApplicationController


    def index
      @universities = University.all
      # debugger
    end

    def show
      @universities = University.find(params[:id])
    end

    def new
      @universities = University.new
    end

end