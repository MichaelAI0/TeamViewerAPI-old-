require "jwt"


module TeamApi
  # Handles user authentication (login, logout)
  module Auth
    
    def self.login(email, password)

      # will return nil if no user found, will return false if the try authenticate doesn't work
      @curent_user = User.find_by_email(email)
      if @current_user&.authenticate(password)
        token = JsonWebToken.jwt_encode(user_id: @current_user.id)
        ServiceContract.success({ user: @current_user, token: token })
      else
            # If we couldn't find the user
      return ServiceContract.error("User not found") if  @curent_user.nil?

      # If the password wasn't correct
      return ServiceContract.error("Incorrect password") unless  @curent_user
      end
  

    
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
