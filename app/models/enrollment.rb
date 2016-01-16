# == Schema Information
#
# Table name: enrollments
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  course_id   :integer          not null
#  external_id :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  validates :course, presence: true
  validates :user, presence: true, allow_nil: true

  validates :user_id, uniqueness: { scope: :course_id }
end
