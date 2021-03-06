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
    authorize poll
    poll.start!
    render json: poll
  end

  def stop
    poll = course.polls.last!
    authorize poll
    poll.stop!
    render json: poll
  end

  def create
    poll = course.polls.new(poll_params)
    poll.active = true
    authorize poll
    poll.save ? status = :ok : status = :bad_request
    render json: poll, status: status
  end

  def show_response
    poll = course.polls.last!
    render json: current_user.responses.where(poll: poll).first!
  end

  def set_response
    poll = course.polls.last!
    return poll_not_active_error unless poll.active
    return user_not_enrolled_error unless course.students.exists?(current_user.id)
    response = current_user.responses.find_or_initialize_by(poll: poll)
    response.answer = response_params[:answer]
    response.save ? status = :ok : status = :bad_request
    render json: response, status: status
  end

  private

  def poll_params
    params.require(:poll).permit(:description, :choices_count, :answer)
  end

  def response_params
    params.require(:response).permit(:answer)
  end

  def find_course
    self.course = Course.find_by!(access_code: params[:access_code])
  end

  def poll_not_active_error
    render json: { error: 'Can not respond to a closed poll' }, status: :bad_request
  end

  def user_not_enrolled_error
    render json: { error: 'You are not enrolled in this course' }, status: :bad_request
  end
end
