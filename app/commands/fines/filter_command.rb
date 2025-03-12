module Fines
  class FilterCommand < Command
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def execute
      fines = if user.library_personnel?
        Fine.all.includes(loan: [ :resource, :user ])
      else
        user.fines.includes(loan: :resource)
      end

      success(fines: fines)
    end
  end
end
