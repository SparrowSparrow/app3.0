class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.integer :id_speciality
      t.string :speciality

      t.timestamps null: false
    end
  end
end
