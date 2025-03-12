module Reservations
class ApproveCommand < Command
  attr_reader :reservation

  def initialize(reservation)
    @reservation = reservation
  end

  def execute
    if reservation.approve!
      success
    else
      failure(reservation.errors.full_messages)
    end
  end
end
end
