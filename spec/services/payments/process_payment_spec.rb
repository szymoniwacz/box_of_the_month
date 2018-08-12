require 'rails_helper'

describe Payments::ProcessPayment do
  subject { described_class.call({payment_data: payment_data}) }

  context 'when data is valid' do
    let(:payment_data) {{
      "amount": 19.99,
      "card_number": "4242424242424242",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024",
      "zip_code": "10100"
    }}
    it { expect(subject[:success]).to be_truthy }
  end

  context 'when card number is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "card_number": "4242424242424241",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024",
      "zip_code": "10100"
    }}
    it { expect(subject[:error_code]).to eql(1000001) }
  end

  context 'when card has insufficient funds is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "card_number": "4242424242420089",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2024",
      "zip_code": "10100"
    }}
    it { expect(subject[:error_code]).to eql(1000002) }
  end

  context 'when cvv is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "card_number": "4242424242424242",
      "cvv": "111",
      "expiration_month": "01",
      "expiration_year": "2024",
      "zip_code": "10100"
    }}
    it { expect(subject[:error_code]).to eql(1000003) }
  end

  context 'when card is expired is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "card_number": "4242424242424242",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2014",
      "zip_code": "10100"
    }}
    it { expect(subject[:error_code]).to eql(1000004) }
  end

  context 'when token is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "token": "123123123123123123123"
    }}
    it { expect(subject[:error_code]).to eql(1000007) }
  end

  context 'when token is invalid' do
    let(:payment_data) {{
      "amount": 19.99,
      "token": "123123123123123123123",
      "card_number": "4242424242424242",
      "cvv": "123",
      "expiration_month": "01",
      "expiration_year": "2014",
      "zip_code": "10100"
    }}
    it { expect(subject[:error_code]).to eql(1000008) }
  end
end
