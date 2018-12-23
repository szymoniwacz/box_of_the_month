class Error
  class Forbidden < Error
    def initialize
      message = I18n.t(:forbidden, scope: 'errors.messages')
      super(message, :forbidden, {}, 403)
    end
  end
end
