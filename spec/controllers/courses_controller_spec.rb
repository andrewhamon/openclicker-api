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

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

end
