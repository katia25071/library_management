
class Resource < ApplicationRecord
  has_many :loans
  has_many :reservations

  validates :title, presence: true
  validates :publish_year, presence: true, numericality: { only_integer: true }
  validates :language, presence: true
  validates :category, presence: true

  scope :available, -> { where(available: true) }

  scope :search, ->(params) {
  query = all

  if params[:query].present?
    search_term = "%#{params[:query]}%"
    query = query.where("title LIKE :q OR description LIKE :q OR language LIKE :q OR publish_year LIKE :q or author LIKE :q", q: search_term)
  end

  query = query.where(category: params[:category]) if params[:category].present?

  if params[:type].present?
    case params[:type].downcase
    when "book"
      query = query.where(type: "Book")
    when "journal"
      query = query.where(type: "Journal")
    end
  end

  query
}


  def make_unavailable!
    update!(available: false)
  end

  def make_available!
    update!(available: true)
  end
end


  def resource_params
    params.require(:resource).permit(:title, :publish_year, :language, :publisher,
                                   :description, :type, :author, :volume, :issue,
                                   :category)
  end
