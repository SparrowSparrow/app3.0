class CreateConnectionUserCourses < ActiveRecord::Migration
  def change
    create_table :connection_user_courses do |t|
      t.integer :id_user
      t.integer :id_course

      t.timestamps null: false
    end
  end
end
