module Subscriptions
  class SubscriptionSerializer < BaseSerializer
    attributes :href, :id, :plan, :payments

    has_many :payments, serializer: Payments::PaymentSerializer

    def href
      v1_subscription_url(object.id)
    end

    def plan
      Plan.find(object.plan_id)
    end
  end
end
