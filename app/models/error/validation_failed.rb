class Error
  class ValidationFailed < Error
    def initialize(details = {})
      message = I18n.t(:validation_failed, scope: 'errors.messages')
      super(message, :validation_failed, details, 400)
    end
  end
end
