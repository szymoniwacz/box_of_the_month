module V1
  class SubscriptionsController < ApplicationController

    before_action :authorize_customer!

    def create
      form = Subscriptions::CreateSubscriptionForm.new(subscription_params)
      result = Subscriptions::CreateSubscription.call(form: form, customer: customer)
      if result.error?
        render_error(result.object)
      else
        render json: result.object,
               serializer: Subscriptions::SubscriptionSerializer,
               status: :created
      end
    end

    private

    def subscription_params
      @subscription_params ||= params.permit(:plan_id, :card_number, :expiration_date, :cvv, :billing_zip_code)
    end
  end
end
