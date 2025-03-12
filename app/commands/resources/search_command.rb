module Resources
  class SearchCommand < Command
    attr_reader :params

    def initialize(params = {})
      @params = params
    end

    def execute
      resources = Resource.all
      resources = resources.search(params) if params.present?

      success(resources: resources)
    end
  end
end
