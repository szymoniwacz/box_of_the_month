require 'rails_helper'

describe Subscriptions::RenewSubscription do
  let(:customer) { create(:customer_with_token) }
  let(:subscription) { create(:test_subscription_with_payment, customer_id: customer.id) }
  subject { described_class.call(subscription_data) }

  context 'when data is valid' do
    let(:subscription_data) { { subscription_id: subscription.id } }
    it do
      VCR.use_cassette('services/subscriptions/valid_renew') do
        expect(subject.success?).to be_truthy
      end
    end
  end

  context 'when data is invalid' do
    let(:subscription_data) { { subscription_id: 'dummy_id' } }
    it do
      VCR.use_cassette('services/subscriptions/invalid_renew') do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
