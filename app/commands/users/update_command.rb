module Users
  class UpdateCommand < Command
    attr_reader :user, :params

    def initialize(user, params)
      @user = user
      @params = params
    end

    def execute
      if user.update(params)
        success(user: user)
      else
        failure(user.errors.full_messages)
      end
    end
  end
end
