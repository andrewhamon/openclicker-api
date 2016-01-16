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

class Course < ActiveRecord::Base
  belongs_to :user
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user
  has_many :polls

  validates :name, presence: true
  validates :user, presence: true
  validates :access_code, presence: true


  before_validation :generate_access_code

  private

  def generate_access_code
    begin
      self.access_code = SecureRandom.hex(4)
    end while self.class.exists?(access_code: access_code)
  end
end
