require "jwt"

module TeamApi
  # Handles user authentication (login, logout)
  module Auth
    def self.login(email, password, ip)
      # will return nil if no user found, will return false if the try authenticate doesn't work
      user = User.find_by(email: email).try(:authenticate, password)

      # If we couldn't find the user
      return ServiceContract.error("User not found") if user.nil?

      # If the password wasn't correct
      return ServiceContract.error("Incorrect password") unless user

      # generate the JWT token for the user
      token = JWT.encode({ user_id: user.id }, ENV.fetch("SECRET_KEY"), "HS256")
#TODO: Lee - this is happening here
      # create a token record in the database
      token_obj =
        Token.create(
          value: token,
          user_id: user.id,
          expiry: DateTime.current + 7.days,
          ip: ip
        )

      ServiceContract.success({ user: user, token: token_obj })
    end

    def self.logout(user, token)
      if user && token.update(revocation_date: DateTime.now)
        return ServiceContract.success(true)
      end

      ServiceContract.error("Error logging user out")
    end

    def self.clear_other_tokens(user, token)
      if user
        Token
          .where(user_id: user.id)
          .where.not(value: token)
          .update(revocation_date: DateTime.now)
        ServiceContract.success(true)
      else
        ServiceContract.error("Error Revoking Past Logins")
      end
    end
  end
end
