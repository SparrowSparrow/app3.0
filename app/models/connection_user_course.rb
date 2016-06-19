class ConnectionUserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :edu_program
end
