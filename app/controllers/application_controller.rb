require_relative "../lib/json_web_token"
require 'dotenv/load'

class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request

  attr_reader :current_user

  def authenticate_request
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    
    header = request.headers["Authorization"]
    header = header.split(" ").last if header 
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
    @current_user
  end

  def render_unauthorized
    render json: {error:"Bad credentials"}, status: 401
  end

  private

  # def authenticate_request
  #   @current_user = nil
  #   if decoded_auth_token
  #     user_id = decoded_auth_token["user_id"]
  #     @current_user = User.find(user_id)
  #   end
  # rescue JWT::VerificationError, JWT::DecodeError
  #   render json: { error: "Not authorized" }, status: :unauthorized
  # end

  # def http_token
  #   @http_token ||=
  #     if request.headers["Authorization"].present?
  #       request.headers["Authorization"].split(" ").last
  #     end
  # end

  # def decoded_auth_token
  #   @decoded_auth_token ||= JsonWebToken.decode(http_token)
  # end
end
