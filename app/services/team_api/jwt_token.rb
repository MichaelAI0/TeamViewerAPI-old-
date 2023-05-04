# require "jwt"

# module TeamApi
#   module JwtToken
#     SECRET_KEY = "your_secret_key"

#     def self.generate(model)
#       payload = { model_info: model_info(model), random_day: random_day.to_i }

#       JWT.encode(payload, SECRET_KEY, "HS256")
#     end

#     def self.decode(token)
#       decoded_token =
#         JWT.decode(token, SECRET_KEY, true, { algorithm: "HS256" }).first
#       HashWithIndifferentAccess.new(decoded_token)
#     rescue JWT::ExpiredSignature, JWT::VerificationError => e
#       raise Api::Unauthorized, e.message
#     end

#     private

#     def self.model_info(model)
#       "#{model}-#{model.id}-#{model.created_at}"
#     end

#     def self.random_day
#       rand(-200..200).days.ago
#     end
#   end
# end
# #TODO: Lee - this is happening here