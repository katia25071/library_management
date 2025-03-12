class Command
  def self.execute(*args, **kwargs)
    new(*args, **kwargs).execute
  end

  def execute
    raise NotImplementedError, "Subclasses must implement #execute"
  end

  private

  def success(data = {})
    { success: true }.merge(data)
  end

  def failure(errors = [])
    { success: false, errors: Array(errors) }
  end
end
