module Payments
  class PaymentSerializer < ActiveModel::Serializer
    attributes :id, :status, :date, :amount, :error_code

    def status
      return "failed" if object.error_code.present?
      object.success? ? "success" : "processing"
    end

    def date
      object.created_at.to_formatted_s(:db)
    end
  end
end
