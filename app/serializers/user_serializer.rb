class UserSerializer < ApplicationSerializer
  attributes :id, :email
  attribute :token, if: :is_current_user?

  def is_current_user?
    object.id == scope.id
  end
end
