module V1
  class SubscriptionsController < ApplicationController
    def create
      form = Subscriptions::CreateSubscriptionForm.new(subscription_params)
      result = Subscriptions::CreateSubscription.call(form: form)
      if result.error?
        render_error(result.object)
      else
        render json: result.object,
               serializer: Subscriptions::SubscriptionSerializer,
               status: :created
      end
    end
  end
end
