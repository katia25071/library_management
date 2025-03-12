require "rufus-scheduler"

scheduler = Rufus::Scheduler.new

scheduler.every "1m" do
  Rails.logger.info "Running reservation expiry check..."

  Reservation.where(status: "pending").where("expiration_date < ?", Time.current).find_each do |reservation|
    ActiveRecord::Base.transaction do
      reservation.update!(status: "expired")
      reservation.resource.make_available!
    end
  end

  Rails.logger.info "Reservation expiry check completed."
end
