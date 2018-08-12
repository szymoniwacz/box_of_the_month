module Subscriptions
  class SubscriptionSerializer < ActiveModel::Serializer
    attributes :id, :plan, :payments

    has_many :payments, serializer: Payments::PaymentSerializer

    def plan
      Plan.find(object.plan_id)
    end
  end
end
