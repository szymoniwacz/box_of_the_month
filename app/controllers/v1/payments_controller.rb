module V1
  class PaymentsController < ApplicationController
    before_action :authorize_customer!

    def show
      render json: payment,
             serializer: Payments::PaymentSerializer
    end

    private

    def payment
      @payment ||= customer.payments.find(params[:id])
    end
  end
end
