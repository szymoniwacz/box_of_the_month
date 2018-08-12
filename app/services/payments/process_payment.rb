module Payments
  class ProcessPayment
    include Service

    def initialize(attrs = {})
      @payment_data = attrs.fetch(:payment_data)
    end

    def call
      purchase
    end

    private

    attr_reader :payment_data, :request

    def purchase
      @request = HTTParty.post(Settings.payment.url, headers: headers, body: payment_data.to_json)
      new_payment_data
    end

    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'Authorization' => "Token token=#{Settings.payment.token}"
      }
    end

    def new_payment_data
      {
        token: request["token"],
        success: request["success"],
        error_code: request["error_code"],
        amount: payment_data[:amount]
      }
    end
  end
end
