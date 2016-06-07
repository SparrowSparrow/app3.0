class ConnectionUniversityCourse < ActiveRecord::Base
  belongs_to :university
  belongs_to :edu_program
end
