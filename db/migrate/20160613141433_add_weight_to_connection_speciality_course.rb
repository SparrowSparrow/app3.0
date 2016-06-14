class AddWeightToConnectionSpecialityCourse < ActiveRecord::Migration
  def change
    add_column :connection_speciality_courses, :weight, :integer
  end
end
