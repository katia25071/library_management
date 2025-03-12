module Loans
class CloseCommand < Command
  attr_reader :loan

  def initialize(loan)
    @loan = loan
  end

  def execute
    if loan.close!
      success
    else
      failure(loan.errors.full_messages)
    end
  end
end
end
