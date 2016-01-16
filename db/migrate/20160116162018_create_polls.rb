class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :course, index: true, foreign_key: true, null: false
      t.text :description, null: false, default: ''
      t.integer :choices_count, null: false
      t.boolean :active, null: false, default: false

      t.timestamps null: false
    end
  end
end
