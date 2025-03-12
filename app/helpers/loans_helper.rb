module LoansHelper
  def loan_overdue_present?(loans)
    loans.any?(&:overdue?)
  end
end
