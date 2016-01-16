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

class Poll < ActiveRecord::Base
  belongs_to :course
  has_many :responses

  validates :course, presence: true
  validates :description, presence: true
  validates :choices_count, inclusion: 1..5
  validates :answer, inclusion: { in: -> (r) { 1..r.choices_count } }, allow_nil: true

  before_create :set_others_to_inactive
  after_create do
    delay.push_notification
  end
  after_touch do
    delay.push_results
  end

  def start!
    self.update(active: true)
  end

  def stop!
    self.update(active: false)
  end

  def results
    results = responses.group(:answer).count
    (1..choices_count).each do |choice|
      results[choice] ||= 0
    end
    results
  end

  private

  def set_others_to_inactive
    course.polls.update_all(active: false)
  end

  def push_notification
    serializer = PollSerializer.new(self)
    adapter = ActiveModel::Serializer::Adapter.create(serializer)
    Pusher.trigger(course.access_code, 'new_poll', adapter.as_json)
  end

  def push_results
    serializer = PollSerializer.new(self)
    adapter = ActiveModel::Serializer::Adapter.create(serializer)
    Pusher.trigger("#{course.access_code}-#{id}", 'results', adapter.as_json)
  end
end
