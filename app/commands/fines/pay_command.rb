module Fines
  class PayCommand < Command
    attr_reader :fine

    def initialize(fine)
      @fine = fine
    end

    def execute
      if fine.pay!
        success
      else
        failure("Error processing payment")
      end
    end
  end
end
