require "jwt"

module TeamApi
  module AccessToken
    SECRET_KEY = Rails.application.credentials['SECRET_KEY']

    def self.generate(payload, ecdsa_key)
      token = JWT.encode payload, ecdsa_key, 'ES256'
    end

    def self.verify(token)
      JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }).first
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end

    def self.model_info(model)
      "#{model}-#{model.id}-#{model.created_at}"
    end
    
  end
end
#TODO: Lee - this is happening here