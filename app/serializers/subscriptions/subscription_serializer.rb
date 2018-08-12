module Subscriptions
  class SubscriptionSerializer < ActiveModel::Serializer
    attributes :id, :name, :address, :zip_code, :payments

    has_many :payments, serializer: Payments::PaymentSerializer
  end
end
