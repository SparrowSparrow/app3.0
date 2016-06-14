class EduProgram < ActiveRecord::Base
  has_many :connection_university_courses, foreign_key: "id_course"
  has_many :universities, through: :connection_university_course

  has_many :connection_speciality_courses, foreign_key: "id_course"
  has_many :specialities, through: :connection_speciality_course

end
