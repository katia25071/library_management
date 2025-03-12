
class Fine < ApplicationRecord
  belongs_to :loan
  belongs_to :user

  validates :amount, presence: true,
            numericality: {
              greater_than: 0,
              less_than_or_equal_to: 500
            }


  after_initialize :set_defaults, if: :new_record?


  validates :status, inclusion: { in: %w[unpaid paid collected] }

  scope :unpaid, -> { where(status: "unpaid") }
  scope :paid, -> { where(status: "paid") }
  scope :collected, -> { where(status: "collected") }

  def paid?
    status == "paid" || status == "collected"
  end

  def collected?
    status == "collected"
  end

  def unpaid?
    status == "unpaid"
  end

  def pay!
    update(status: "paid")
  end

  def collect!
    update(status: "collected")
  end

  private

  def set_defaults
    self.status ||= "unpaid"
  end
end
