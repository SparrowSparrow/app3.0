class Speciality < ActiveRecord::Base
  has_many :connection_speciality_courses, foreign_key: "id_speciality"
  has_many :edu_programs, through: :connection_speciality_course

end
