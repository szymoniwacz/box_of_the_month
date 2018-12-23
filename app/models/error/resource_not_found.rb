class Error
  class ResourceNotFound < Error
    def initialize(message = nil)
      message ||= I18n.t(:resource_not_found, scope: 'errors.messages')
      super(message, :resource_not_found, {}, 404)
    end
  end
end
