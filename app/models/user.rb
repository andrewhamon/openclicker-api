class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :token, presence: true
end
