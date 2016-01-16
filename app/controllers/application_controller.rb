class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  attr_accessor :current_user
  before_action :authenticate_with_token

  def current_user
    @current_user ||= User.new
  end

  private

  def authenticate_with_token
    authenticate_or_request_with_http_token do |token, _|
      @current_user = User.find_by(token: token)
    end
  end
end
