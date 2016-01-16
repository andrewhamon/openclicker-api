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
#  answer        :integer
#

class PollSerializer < ApplicationSerializer
  attr_accessor :response

  attributes :id, :description, :choices_count, :active
  belongs_to :course
  attribute :answer, if: :active?
  attribute :results, if: :is_instructor_or_closed?
  has_one :response

  def poll_is_inactive?
    !object.active
  end

  def response
    scope.responses.where(poll_id: object.id).first
  end

  def is_instructor_or_closed?
    object.course.user_id == scope.id || !active?
  end

  def active?
    object.active?
  end
end
