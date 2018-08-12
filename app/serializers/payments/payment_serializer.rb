module Payments
  class PaymentSerializer < ActiveModel::Serializer
    attributes :status, :date, :amount, :error_code

    def status
      object.success? ? "success" : "failed"
    end

    def date
      object.created_at.to_formatted_s(:db)
    end
  end
end
