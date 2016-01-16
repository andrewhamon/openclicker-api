# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  course_id     :integer          not null
#  description   :text             default(""), not null
#  choices_count :integer          not null
#  active        :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Poll < ActiveRecord::Base
  belongs_to :course

  validates :course, presence: true
  validates :description, presence: true
  validates :choices_count, inclusion: 1..5

  before_create :set_others_to_inactive

  def start!
    self.update(active: true)
  end

  def stop!
    self.update(active: false)
  end

  private

  def set_others_to_inactive
    course.polls.update_all(active: false)
  end
end
