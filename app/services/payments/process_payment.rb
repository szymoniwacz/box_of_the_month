module Payments
  class ProcessPayment
    include Service

    def initialize(attrs = {})
      @payment = attrs.fetch(:payment)
      @payment_data = attrs.fetch(:payment_data)
    end

    def call
      purchase
    end

    private

    attr_reader :payment_data, :request

    def purchase
      @request = HTTParty.post(Settings.payment.url, headers: headers, body: payment_data.to_json)
      # puts "payment: #{payment.inspect}"
      payment.update(new_payment_data)
      # puts "updated payment: #{payment.inspect}"
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
        amount: payment_data[:amount],
        status: payment_status
      }
    end

    def payment_status
      request["success"] ? Payment::SUCCESS : Payment::FAILED
    end
  end
end
