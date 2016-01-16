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
  attributes :id, :name
  attribute :access_code, if: :user_is_owner?
  has_one :user, key: :instructor

  private

  def user_is_owner?
    scope.id == object.user_id
  end
end
