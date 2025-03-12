module Fines
class CollectCommand < Command
  attr_reader :fine

  def initialize(fine)
    @fine = fine
  end

  def execute
    if fine.collect!
      success
    else
      failure("Error collecting payment")
    end
  end
end
end
