class CreateConnectionUniversityCourses < ActiveRecord::Migration
  def change
    create_table :connection_university_courses do |t|
      t.integer :id_course
      t.integer :id_university

      t.timestamps null: false
    end
  end
end
