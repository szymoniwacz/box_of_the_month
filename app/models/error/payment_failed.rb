class Error
  class PaymentFailed < Error
    def initialize(error_code = nil)
      puts "Error::PaymentFailed"
      message = I18n.t(:payment_failed, scope: 'errors.messages')
      error_details = I18n.t(error_code, scope: 'errors.messages.payments.error_codes')

      super(message, :payment_failed, error_details, 400)
    end
  end
end
