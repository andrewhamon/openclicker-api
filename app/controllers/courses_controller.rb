# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  user_id     :integer          not null
#  access_code :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class CoursesController < ApplicationController
  attr_accessor :course
  before_action :find_course, only: [:enroll, :show]

  def create
    self.course = Course.new(course_params)
    course.user = current_user
    course.save ? status = :created : status = :bad_request
    render json: course, status: status
  end

  def enroll
    enrollment = Enrollment.find_or_initialize_by(course: course, user: current_user)
    return render json: course unless enrollment.new_record?
    enrollment.save ? status = :created : status = :bad_request
    render json: course, status: status
  end

  def show
    render json: course, include: [:instructor, polls: [:response]]
  end

  private

  def course_params
    params.require(:course).permit(:name, :access_code)
  end

  def find_course
    self.course = Course.find_by!(access_code: params[:access_code])
  end
end
