class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit
  attr_accessor :current_user
  before_action :authenticate_with_token
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    @current_user ||= User.new
  end

  private

  def authenticate_with_token
    authenticate_or_request_with_http_token do |token, _|
      @current_user = User.find_by(token: token)
    end
  end

  def user_not_authorized
    render nothing: true, status: :unauthorized
  end
end
