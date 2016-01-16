# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UserSerializer < ApplicationSerializer
  attributes :id, :email
  attribute :token, if: :is_current_user?

  def is_current_user?
    object.id == scope.id
  end
end
