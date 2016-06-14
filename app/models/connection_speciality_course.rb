class ConnectionSpecialityCourse < ActiveRecord::Base
  belongs_to :speciality
  belongs_to :edu_program
end