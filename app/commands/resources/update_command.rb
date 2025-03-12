class UpdateCommand < Command
  attr_reader :resource, :params

  def initialize(resource, params)
    @resource = resource
    @params = params
  end

  def execute
    if resource.update(params)
      success(resource: resource)
    else
      failure(resource.errors.full_messages)
    end
  end
end
