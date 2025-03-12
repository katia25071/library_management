class LoansController < ApplicationController
  before_action :require_login
  before_action :require_library_personnel, except: [ :index, :show ]
  before_action :set_loan, only: [ :show, :return, :close ]

  def index
    result = Loans::FilterCommand.execute(current_user, params[:filter])
    @loans = result[:loans]
  end

  def show
    unless current_user.library_personnel? || @loan.user_id == current_user.id
      redirect_to loans_path, alert: "You are not authorized to view this loan."
    end
  end

  def create
    result = Loans::CreateCommand.execute(loan_params)

    if result[:success]
      redirect_to result[:loan], notice: "Loan was successfully created."
    else
      redirect_back fallback_location: root_path,
                    alert: "Could not create loan: #{result[:errors].join(', ')}"
    end
  end

  def return
    result = Loans::ReturnCommand.execute(@loan)

    if result[:success]
      redirect_to loans_path, notice: "Resource returned successfully."
    else
      redirect_to loans_path, alert: "Error returning resource: #{result[:errors].join(', ')}"
    end
  end

  def close
    result = Loans::CloseCommand.execute(@loan)

    if result[:success]
      redirect_to loans_path, notice: "Loan closed and fine collected successfully."
    else
      redirect_to loans_path, alert: "Error closing loan: #{result[:errors].join(', ')}"
    end
  end

  def overdue
    require_library_personnel
    result = Loans::FilterCommand.execute(current_user, "overdue")
    @loans = result[:loans]
    render :index
  end

  def outstanding
    require_library_personnel
    result = Loans::FilterCommand.execute(current_user, "outstanding")
    @loans = result[:loans]
    render :index
  end

  def past
    result = Loans::FilterCommand.execute(current_user, "past")
    @loans = result[:loans]
    render :index
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:user_id, :resource_id, :loan_date)
  end
end
