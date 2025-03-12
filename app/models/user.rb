
class User < ApplicationRecord
  has_secure_password

  has_many :loans
  has_many :reservations
  has_many :fines

  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_type, presence: true, inclusion: {
    in: [ "anonymous", "library_user", "library_personnel" ],
    message: "%{value} is not a valid user type"
  }


  scope :search_by_term, ->(term) {
    where("name LIKE :term OR surname LIKE :term OR email LIKE :term", term: "%#{term}%")
  }

  def full_name
    "#{name} #{surname}"
  end

  def library_user?
    user_type == "library_user"
  end

  def library_personnel?
    user_type == "library_personnel"
  end

  def anonymous?
    user_type == "anonymous"
  end
end
