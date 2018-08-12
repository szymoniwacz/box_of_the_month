module Subscriptions
  class CreateSubscription
    include Service

    def initialize(attrs = {})
      @form = attrs.fetch(:form)
    end

    def call
      return build_result(validation_error) if form.invalid?
      process_payment
      return build_result(payment_error) unless payment.success?
      build_result(subscription)
    end

    private

    attr_reader :plan

    def process_payment
      @payment = subscription.payments.create(Payments::ProcessPayment.call({payment_data: payment_data}))
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
      @subscription ||= Subscription.create(form.to_hash)
    end

    def plan
      @plan ||= Plan.find(form[:plan_id])
    end
  end
end
