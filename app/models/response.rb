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

class Response < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  validates :user, presence: true
  validates :poll, presence: true

  validates :answer, inclusion: { in: -> (r) { 1..r.poll.choices_count } }
  validates :user, uniqueness: { scope: :poll_id }
end
