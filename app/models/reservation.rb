
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :resource

  validates :reservation_date, presence: true
  validates :expiration_date, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected expired] }

  before_create :set_expiration_date

  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }
  scope :rejected, -> { where(status: "rejected") }
  scope :expired, -> { where(status: "expired") }

  def approve!
    transaction do
      update!(status: "approved")
      create_loan
      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end
  end

  def reject!
    update(status: "rejected")
  end

  private

  def set_expiration_date
    self.expiration_date = 2.hours.from_now
  end

  def create_loan
    Loan.create!(
      user: user,
      resource: resource,
      loan_date: Time.current,
      due_date: 2.weeks.from_now
    )
  end
end
