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

class PollsController < ApplicationController
  attr_accessor :course
  before_action :find_course

  def index
    render json: course.polls.order(id: :desc)
  end

  def show_current
    render json: course.polls.last!
  end

  def show
    render json: course.polls.find(params[:id])
  end

  def start
    poll = course.polls.last!
    poll.start!
    render json: poll
  end

  def stop
    poll = course.polls.last!
    poll.stop!
    render json: poll
  end

  def create
    poll = course.polls.new(poll_params)
    poll.save ? status = :ok : status = :bad_request
    render json: poll, status: status
  end

  private

  def poll_params
    params.require(:poll).permit(:description, :choices_count)
  end

  def find_course
    self.course = Course.find_by!(access_code: params[:access_code])
  end
end
