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

class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :enrolled
  attribute :access_code, if: :user_is_owner?
  has_one :user, key: :instructor

  def user_is_owner?
    scope.id == object.user_id
  end

  def enrolled
    object.students.exists?(scope.id)
  end
end
