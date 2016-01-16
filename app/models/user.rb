class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true, if: :email_changed?
  validates :token, presence: true

  before_validation :generate_token
  before_validation :downcase_email

  private

  def generate_token
    self.token = SecureRandom.uuid
  end

  def downcase_email
    self.email = self.email.to_s.downcase
  end
end
