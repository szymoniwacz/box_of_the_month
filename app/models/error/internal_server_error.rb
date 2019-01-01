class Error
  class InternalServerError < Error
    def initialize(message = nil, details = nil)
      message ||= I18n.t(:internal_server_error, scope: 'errors.messages')
      super(message, :internal_server_error, details, 500)
    end
  end
end
