class AddAnswerToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :answer, :integer
  end
end
