module Payments
  class PaymentSerializer < ActiveModel::Serializer
    attributes :id, :status, :date, :amount, :error_code

    def date
      object.created_at.to_formatted_s(:db)
    end
  end
end
