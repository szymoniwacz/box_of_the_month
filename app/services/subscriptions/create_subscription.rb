module Subscriptions
  class CreateSubscription
    include Service

    def initialize(attrs = {})
      @form = attrs.fetch(:form)
      @customer = attrs.fetch(:customer)
    end

    def call
      return build_result(validation_error) if form.invalid?
      subscription.update(status: Subscription::NEW)
      process_payment
      subscription.update(status: Subscription::ACTIVE) if payment.success?
      build_result(subscription)
    end

    private

    attr_reader :plan, :customer

    def process_payment
      if Settings.async
        Payments::ProcessPaymentJob.perform_later(payment_id: payment.id, payment_data: payment_data)
      else
        Payments::ProcessPayment.call(payment: payment, payment_data: payment_data)
      end
    end

    def payment_data
      {
        "amount": plan.price.to_s,
        "card_number": form[:card_number],
        "cvv": form[:cvv],
        "expiration_month": Date.parse(form[:expiration_date]).strftime("%m"),
        "expiration_year": Date.parse(form[:expiration_date]).strftime("%Y"),
        "zip_code": form[:billing_zip_code]
      }
    end

    def subscription
      @subscription ||= customer.subscriptions.create(form.to_hash)
    end

    def payment
      @payment ||= subscription.payments.create
    end

    def plan
      @plan ||= Plan.find(form[:plan_id])
    end
  end
end
