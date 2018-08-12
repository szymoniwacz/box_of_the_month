module Service
  extend ActiveSupport::Concern

  module ClassMethods
    def call(attrs = {})
      new(attrs).call
    end
  end

  private

  attr_reader :form, :payment

  def validation_error
    Error::ValidationFailed.new(form.errors)
  end

  def build_result(object = nil)
    ServiceResult.new(object)
  end

  def payment_error
    Error::PaymentFailed.new(payment.error_code)
  end
end
