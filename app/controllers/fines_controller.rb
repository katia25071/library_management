class FinesController < ApplicationController
  before_action :require_login
  before_action :set_fine, only: [ :show, :pay, :collect ]
  before_action :require_library_personnel, only: [ :pay, :collect ]

  def index
    result = Fines::FilterCommand.execute(current_user)
    @fines = result[:fines]
  end

  def show
    unless current_user.library_personnel? || @fine.user_id == current_user.id
      redirect_to fines_path, alert: "You are not authorized to view this fine."
    end
  end

  def pay
    result = Fines::PayCommand.execute(@fine)

    if result[:success]
      redirect_to fines_path, notice: "Fine was successfully paid."
    else
      redirect_to fines_path, alert: "Error processing payment."
    end
  end

  def collect
    result = Fines::CollectCommand.execute(@fine)

    if result[:success]
      redirect_to fines_path, notice: "Fine was successfully collected."
    else
      redirect_to fines_path, alert: "Error collecting payment."
    end
  end

  private

  def set_fine
    @fine = Fine.find(params[:id])
  end
end
