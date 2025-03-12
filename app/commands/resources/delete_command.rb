class DeleteCommand < Command
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def execute
    if resource.destroy
      success
    else
      failure("Could not delete the resource")
    end
  end
end
