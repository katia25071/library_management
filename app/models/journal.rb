class Journal < Resource
  validates :volume, presence: true, numericality: { only_integer: true }
  validates :issue, presence: true, numericality: { only_integer: true }
end
