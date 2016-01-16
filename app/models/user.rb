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

class User < ActiveRecord::Base
  has_secure_password

  before_validation :generate_token
  before_validation :downcase_email, if: :email_changed?

  validates :email, presence: true
  validates :email, uniqueness: true, if: :email_changed?
  validates :token, presence: true

  has_many :courses_taught, class_name: 'Course'
  has_many :enrollments
  has_many :courses, through: :enrollments
  has_many :responses

  private

  def generate_token
    begin
      self.token = SecureRandom.uuid
    end while self.class.exists?(token: token)
  end

  def downcase_email
    self.email = self.email.to_s.downcase
  end
end
