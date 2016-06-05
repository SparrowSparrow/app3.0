class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :contact
      t.string :address
      t.integer :students
      t.string :price

      t.timestamps null: false
    end
  end
end
