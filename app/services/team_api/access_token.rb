require "jwt"

module TeamApi
  module AccessToken
    SECRET_KEY = ENV["SECRET_KEY"]

    def self.generate(model)
      payload = { model_type: model.class.name, model_id: model.id }
      JWT.encode(payload, SECRET_KEY, "HS256")
    end

    def self.verify(token)
      JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }).first
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end
  end
end
#TODO: Lee - this is happening here