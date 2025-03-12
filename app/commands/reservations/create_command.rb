module Reservations
  class CreateCommand < Command
    attr_reader :user, :resource

    def initialize(user, resource)
      @user = user
      @resource = resource
    end

    def execute
      unless resource.available?
        return failure("Resource is not available for reservation.")
      end

      current_time = Time.current
      reservation = user.reservations.build(
        resource: resource,
        reservation_date: current_time,
        expiration_date: current_time + 2.hours,
        status: "pending"
      )

      if reservation.save
        resource.update(available: false)
        success(reservation: reservation)
      else
        failure(reservation.errors.full_messages)
      end
    end
  end
end
