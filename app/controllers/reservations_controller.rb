class ReservationsController < ApplicationController
  before_action :require_login
  before_action :set_reservation, only: [ :approve, :reject ]
  before_action :require_library_personnel, only: [ :approve, :reject ]

  def index
    result = Reservations::FilterCommand.execute(current_user)
    @pending_reservations = result[:pending_reservations]
    @approved_reservations = result[:approved_reservations]
    @rejected_reservations = result[:rejected_reservations]
    @expired_reservations = result[:expired_reservations]
  end

  def create
    @resource = Resource.find(params[:resource_id])
    result = Reservations::CreateCommand.execute(current_user, @resource)

    if result[:success]
      redirect_to root_path, notice: "Resource reserved successfully! Your reservation will expire in 2 hours."
    else
      redirect_to root_path, alert: "Could not reserve the resource: #{result[:errors].join(', ')}"
    end
  end

  def approve
    result = Reservations::ApproveCommand.execute(@reservation)

    if result[:success]
      redirect_to reservations_path, notice: "Reservation approved and loan created successfully."
    else
      redirect_to reservations_path, alert: "Could not approve reservation: #{result[:errors].join(', ')}"
    end
  end

  def reject
    result = Reservations::RejectCommand.execute(@reservation)

    if result[:success]
      redirect_to reservations_path, notice: "Reservation rejected successfully."
    else
      redirect_to reservations_path, alert: "Could not reject reservation: #{result[:errors].join(', ')}"
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
