class CreateCommand < Command
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def execute
    resource = Resource.new(params)

    if resource.save
      success(resource: resource)
    else
      failure(resource.errors.full_messages)
    end
  end
end
