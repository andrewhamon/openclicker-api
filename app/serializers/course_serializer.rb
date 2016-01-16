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

class CourseSerializer < ApplicationSerializer
  attributes :id, :name, :enrolled, :access_code
  has_one :user, key: :instructor
  has_many :polls

  def enrolled
    object.students.exists?(scope.id)
  end
end
