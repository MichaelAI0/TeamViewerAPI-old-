class User < ApplicationRecord
  has_secure_password validations: true
  validates :email, uniqueness: true
  has_many :tokens

  def generate_token!(ip)
    payload = { user_id: id, ip: ip }
    token = JWT.encode(payload, TeamApi::AccessToken::SECRET_KEY, "HS256")
    Token.create(
      value: token,
      user_id: id,
      expiry: DateTime.current + 7.days,
      ip: ip
    )
  end

  def verify_token(token)
    decoded_token =
      begin
        JWT.decode(
          token,
          TeamApi::AccessToken::SECRET_KEY,
          true,
          { algorithm: "HS256" }
        )
      rescue StandardError
        nil
      end
    decoded_token&.first&.dig("user_id") == id
  end

  def generate_invitation_token
    self.invitation_expiration = DateTime.current + 7.day
    loop do
      # Once we have a random, test whether it is unique in the DB
      self.invitation_token = SecureRandom.alphanumeric(15)
      break unless self.class.exists?(invitation_token: invitation_token)
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def invitation_accepted_at!
    update(
      invitation_accepted: true,
      invitation_token: nil,
      invitation_expiration: nil
    )
  end
end
