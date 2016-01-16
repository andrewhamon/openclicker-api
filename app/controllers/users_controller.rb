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

class UsersController < ApplicationController
  skip_before_action :authenticate_with_token, only: [:register, :login]

  def register
    self.current_user = User.new(user_params)
    current_user.save ? status = :created : status = :bad_request
    render json: current_user, status: status
  end

  def login
    self.current_user = User.find_by(email: user_params[:email].to_s.downcase)
    return user_not_authenticated if current_user.new_record?
    return user_not_authenticated unless current_user.authenticate(user_params[:password])
    render json: current_user
  end

  private

  def user_not_authenticated
    render nothing: true, status: :unauthorized
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
