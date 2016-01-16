class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true, null: false
      t.string :external_id, index: true

      t.timestamps null: false
    end
    add_index :enrollments, [:user_id, :course_id]
  end
end
