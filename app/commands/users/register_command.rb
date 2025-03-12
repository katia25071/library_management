module Users
class RegisterCommand < Command
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def execute
    user = User.new(params)
    user.user_type = "library_user"

    if user.save
      success(user: user)
    else
      failure(user.errors.full_messages)
    end
  end
end
end
