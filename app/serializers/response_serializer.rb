# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  poll_id    :integer
#  answer     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ResponseSerializer < ApplicationSerializer
  attributes :id, :answer
  has_one :user
  has_one :poll
  attribute :correct, if: :poll_is_inactive?

  def poll_is_inactive?
    !object.poll.active
  end

  def correct
    object.answer == object.poll.answer
  end
end
