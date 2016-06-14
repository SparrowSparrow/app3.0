class University < ActiveRecord::Base
  has_many :connection_university_courses, foreign_key: "id_university"
  has_many :edu_programs, through: :connection_university_course


end