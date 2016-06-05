class StudyController < ApplicationController


    def area_show

    end

    def university_show
      @university = University.find(params[:id])
    end

    def university_new
      @university = University.new
    end

    def university_list
      @university = University.all
    end

    

end