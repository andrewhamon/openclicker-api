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

  attributes :id, :description, :choices_count, :active, :responded
  belongs_to :course
  attribute :responded_correctly, if: :poll_is_inactive?
  attribute :answer, if: :poll_is_inactive?
  attribute :results, if: :is_instructor?

  def poll_is_inactive?
    !object.active
  end

  def responded_correctly
    self.response ||= scope.responses.where(poll_id: object.id).first
    return false unless response.present?
    response.answer == object.answer
  end

  def responded
    self.response ||= scope.responses.where(poll_id: object.id).first
    self.response.present?
  end

  def is_instructor?
    object.course.user_id == scope.id
  end
end
