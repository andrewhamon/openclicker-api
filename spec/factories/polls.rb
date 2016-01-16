# == Schema Information
#
# Table name: polls
#
#  id            :integer          not null, primary key
#  course_id     :integer          not null
#  description   :text             default(""), not null
#  choices_count :integer          not null
#  active        :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  answer        :integer
#

FactoryGirl.define do
  factory :poll do
    description { Faker::Hipser.sentence }
    choices_count { (1..5).to_a.sample }
    active false
  end
end
