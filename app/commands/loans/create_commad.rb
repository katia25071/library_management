module Loans
  class CreateCommand < Command
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def execute
      loan = Loan.new(params)

      if loan.save
        success(loan: loan)
      else
        failure(loan.errors.full_messages)
      end
    end
  end
end
