class CreateEduPrograms < ActiveRecord::Migration
  def change
    create_table :edu_programs do |t|
      t.integer :id_course
      t.string :area
      t.string :course

      t.timestamps null: false
    end
  end
end
