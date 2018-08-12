require 'rails_helper'

describe Subscriptions::SubscriptionSerializer, type: :serializer do
  let(:resource) { create(:test_subscription_with_payments) }
  let(:serializer) { described_class.new(resource) }

  subject { JSON.parse(serializer.to_json) }

  describe 'result' do
    it {
      expect(subject['id']).to eql(resource.id)
      expect(subject['name']).to eql(resource.name)
      expect(subject['address']).to eql(resource.address)
      expect(subject['zip_code']).to eql(resource.zip_code)
      expect(subject['payments']).to eql([{
        "amount" => resource.payments.first.amount,
        "date" => resource.payments.first.created_at.to_formatted_s(:db),
        "status" => resource.payments.first.success? ? "success" : "failed",
      }])
    }
  end
end
