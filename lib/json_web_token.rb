require "jwt"

class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, ENV['SECRET_KEY'])
  end

  def self.decode(token)
    JWT.decode(token, ENV['SECRET_KEY'])[0]
  rescue
    nil
  end
end
#TODO: Lee - this is happening here