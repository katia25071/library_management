module Reservations
  class FilterCommand < Command
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def execute
      base_query = if user.library_personnel?
        Reservation.all
      else
        user.reservations
      end

      base_query = base_query.includes(:user, :resource)

      success(
        pending_reservations: base_query.pending,
        approved_reservations: base_query.approved,
        rejected_reservations: base_query.rejected,
        expired_reservations: base_query.expired
      )
    end
  end
end
