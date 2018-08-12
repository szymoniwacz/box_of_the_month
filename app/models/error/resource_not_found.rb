class Error
  class ResourceNotFound < Error
    def initialize(key = nil, value = {})
      message = I18n.t(:resource_not_found, scope: 'errors.messages', id: value.fetch(:id, nil))
      super(message, :resource_not_found, {}, 404)
    end
  end
end
