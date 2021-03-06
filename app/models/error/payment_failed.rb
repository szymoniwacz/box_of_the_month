class Error
  class PaymentFailed < Error
    def initialize(error_code = nil)
      message = I18n.t(:payment_failed, scope: 'errors.messages')
      error_details = {
        error_code: error_code,
        error: I18n.t(error_code, scope: 'errors.messages.payments.error_codes')
      }
      super(message, :payment_failed, error_details, 400)
    end
  end
end
