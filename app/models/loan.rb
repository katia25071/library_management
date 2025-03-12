
class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :resource
  has_one :fine

  validates :loan_date, presence: true
  validates :due_date, presence: true

  before_create :set_due_date
  after_create :make_resource_unavailable

  scope :active, -> { where(active: true) }
  scope :overdue, -> { active.where("due_date < ?", Time.current) }
  scope :past, -> { where(active: false) }
  scope :outstanding, -> { active.where("due_date >= ?", Time.current) }

  def overdue?
    active? && due_date < Time.current
  end

  def return!(if_overdue: true)
    transaction do
      was_overdue = overdue?
      update!(active: false, return_date: Time.current)
      resource.make_available!

      if if_overdue && was_overdue
        days_overdue = (Time.current.to_date - due_date.to_date).to_i
        amount = [ days_overdue * 50.0, 500.0 ].min


        Fine.create!(
          loan: self,
          user: user,
          amount: amount,
          paid: false
        )
      end

      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Could not return loan: #{e.message}")
      false
    end
  end
  def close!
    transaction do
      return!(if_overdue: false)
      if fine.present?
        fine.update!(status: "collected")
      end
      true
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, "Could not close loan: #{e.message}")
      false
    end
  end

  private

  def set_due_date
    self.due_date = loan_date + 2.weeks
  end

  def make_resource_unavailable
    resource.make_unavailable!
  end

  def create_fine
    days_overdue = (Time.current.to_date - due_date.to_date).to_i
    amount = [ days_overdue * 50.0, 500.0 ].min


    create_fine(amount: amount, user: user, paid: false)
  end
end
