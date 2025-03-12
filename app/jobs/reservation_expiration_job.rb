class ReservationExpirationJob < ApplicationJob
  queue_as :default

  def perform
    Reservation.pending.expired.find_each do |reservation|
      ActiveRecord::Base.transaction do
        reservation.update!(status: "expired")
        reservation.resource.make_available!
      end
    end
  end
end
