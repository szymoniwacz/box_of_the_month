require 'rails_helper'

describe Subscriptions::SubscriptionSerializer, type: :serializer do
  let(:customer) { create(:customer_with_token) }
  let(:resource) { create(:test_subscription, customer_id: customer.id) }
  let(:serializer) { described_class.new(resource) }

  subject { JSON.parse(serializer.to_json) }

  describe 'result' do
    it {
      expect(subject['id']).to eql(resource.id)
      expect(subject['href']).to eql("http://test.host.com/v1/subscriptions/#{resource.id}")
      expect(subject['status']).to eql(resource.status)
    }
  end
end
