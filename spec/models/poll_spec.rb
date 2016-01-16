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

require 'rails_helper'

RSpec.describe Poll, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
