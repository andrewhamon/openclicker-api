class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.string :access_code, index: true, null: false

      t.timestamps null: false
    end
  end
end
