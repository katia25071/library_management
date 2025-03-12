module Users
class SearchCommand < Command
  attr_reader :term

  def initialize(term = nil)
    @term = term
  end

  def execute
    users = if term.present?
      User.search_by_term(term)
    else
      User.all
    end

    success(users: users)
  end
end
end
