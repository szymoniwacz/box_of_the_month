module Payments
  class ProcessPaymentJob < ActiveJob::Base
    queue_as :default

    def perform(options = {})
      payment = Payment.find(options.fetch(:payment_id))
      payment_data = options.fetch(:payment_data)
      Payments::ProcessPayment.call(payment: payment, payment_data: payment_data)
    end
  end
end
