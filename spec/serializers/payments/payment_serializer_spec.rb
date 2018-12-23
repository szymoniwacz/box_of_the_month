require 'rails_helper'

describe Payments::PaymentSerializer, type: :serializer do
  let(:customer) { create(:customer_with_token) }
  let(:subscription) { create(:test_subscription, customer_id: customer.id) }
  let(:resource) { create(:payment, subscription_id: subscription.id, amount: subscription.plan.price) }
  let(:serializer) { described_class.new(resource) }

  subject { JSON.parse(serializer.to_json) }

  describe 'result' do
    it {
      expect(subject['href']).to eql("http://test.host.com/v1/payments/#{resource.id}")
      expect(subject['id']).to eql(resource.id)
      expect(subject['amount']).to eql(resource.amount)
      expect(subject['date']).to eql(resource.created_at.to_formatted_s(:db))
      expect(subject['status']).to eql(resource.status)
    }
  end
end
