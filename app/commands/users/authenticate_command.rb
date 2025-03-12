module Users
  class AuthenticateCommand < Command
    attr_reader :email, :password

    def initialize(email, password)
      @email = email
      @password = password
    end

    def execute
      user = User.find_by(email: email)

      if user&.authenticate(password)
        success(user: user)
      else
        failure("Incorrect email or password")
      end
    end
  end
end
