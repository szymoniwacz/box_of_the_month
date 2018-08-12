module Subscriptions
  class RenewSubscription
    include Service

    def initialize(attrs = {})
      @subscription_id = attrs.fetch(:subscription_id)
    end

    def call
      renew_payment
      build_result(subscription)
    end

    private

    attr_reader :plan, :subscription_id

    def renew_payment
      @payment = subscription.payments.create(Payments::ProcessPayment.call({payment_data: payment_data}))
      return build_result(payment_error) unless @payment.success?
    end

    def payment_data
      {
        "amount": subscription.plan.price.to_s,
        "token": subscription.payments.last.token
      }
    end

    def subscription
      @subscription ||= Subscription.find(subscription_id)
    end
  end
end
