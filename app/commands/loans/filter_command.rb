module Loans
  class FilterCommand < Command
    attr_reader :user, :filter

    def initialize(user, filter = nil)
      @user = user
      @filter = filter
    end

    def execute
      loans = if user.library_personnel?
        case filter
        when "overdue"
          Loan.overdue
        when "outstanding"
          Loan.outstanding
        when "past"
          Loan.past
        else
          Loan.all
        end.includes(:user, :resource)
      else
        user.loans.includes(:resource)
      end
      success(loans: loans)
    end
  end
end
