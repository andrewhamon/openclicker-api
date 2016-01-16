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
  def create
    course = Course.new(course_params)
    course.user = current_user
    course.save ? status = :created : status = :bad_request
    render json: course, status: status
  end

  def enroll
    course = Course.find_by!(access_code: course_params[:access_code])
    enrollment = Enrollment.new(course: course, user: current_user)
    enrollment.save ? status = :created : status = :bad_request
    render json: course, status: status
  end

  def show
    course = Course.find_by!(access_code: params[:access_code])
    render json: course
  end

  private

  def course_params
    params.require(:course).permit(:name, :access_code)
  end
end
