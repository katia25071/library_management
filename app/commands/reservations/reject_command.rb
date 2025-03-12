module Reservations
class RejectCommand < Command
  attr_reader :reservation

  def initialize(reservation)
    @reservation = reservation
  end

  def execute
    if reservation.reject!
      reservation.resource.update(available: true)
      success
    else
      failure(reservation.errors.full_messages)
    end
  end
end
end
