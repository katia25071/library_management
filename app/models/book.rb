class Book < Resource
  validates :author, presence: true
end
