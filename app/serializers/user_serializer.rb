class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :token

  def filter(keys)
    if scope == object
      keys
    else
      keys - [:token]
    end
  end
end
