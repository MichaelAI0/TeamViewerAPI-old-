require "jwt"

module JsonWebToken
    extend ActiveSupport::Concern
    SECRET_KEY = Rails.application.credentials["SECRET_KEY"]

    def self.jwt_encode(payload, exp = 7.days.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    def self.jwt_decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithInfferentAccess.new decoded
    end
end