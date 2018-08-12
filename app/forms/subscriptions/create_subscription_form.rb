module Subscriptions
  class CreateSubscriptionForm < Form

    attribute :name, String
    attribute :address, String
    attribute :zip_code, String
    attribute :plan_id, Integer
    attribute :card_number, Integer
    attribute :expiration_date, String
    attribute :cvv, Integer
    attribute :billing_zip_code, String

    validates :name, :address, :zip_code, :plan_id, :card_number, :expiration_date, :cvv, :billing_zip_code,
              presence: true

    def to_hash
      super.except(:card_number, :expiration_date, :cvv, :billing_zip_code)
    end
  end
end
