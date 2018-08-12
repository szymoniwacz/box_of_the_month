class ServiceResult
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def error?
    object.is_a?(Error)
  end

  def success?
    !error?
  end
end
