module Loans
class ReturnCommand < Command
  attr_reader :loan

  def initialize(loan)
    @loan = loan
  end

  def execute
    if loan.return!
      success
    else
      failure(loan.errors.full_messages)
    end
  end
end
end
