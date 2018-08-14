module Payments
  class PaymentSerializer < BaseSerializer
    include NullAttributesRemover

    attributes :href, :id, :status, :date, :amount, :error_code, :error

    def href
      v1_payment_url(object.id)
    end

    def date
      object.created_at.to_formatted_s(:db)
    end

    def error
      object.error_code.present? ? I18n.t(object.error_code, scope: 'errors.messages.payments.error_codes') : nil
    end
  end
end
