require "jwt"

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials['SECRET_KEY'])
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials['SECRET_KEY'])[0]
  rescue
    nil
  end
end
#TODO: Lee - this is happening here