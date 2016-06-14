class CreateConnectionSpecialityCourses < ActiveRecord::Migration
  def change
    create_table :connection_speciality_courses do |t|
      t.integer :id_speciality
      t.integer :id_course
      t.integer :weight

      t.timestamps null: false
    end
  end
end
