module Subscriptions
  class CancelSubscription
    include Service

    def initialize(attrs = {})
      @id = attrs.fetch(:id)
    end

    def call
      subscription.update(status: Subscription::CANCELED)
    end

    private

    attr_reader :id, :subscription

    def subscription
      @subscription ||= Subscription.find(id)
    end
  end
end
