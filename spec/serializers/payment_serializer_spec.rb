require 'rails_helper'

describe Payments::PaymentSerializer, type: :serializer do
  let(:subscription) { create(:test_subscription) }
  let(:resource) { create(:payment, subscription_id: subscription.id,
                                         amount: subscription.plan.price) }
  let(:serializer) { described_class.new(resource) }

  subject { JSON.parse(serializer.to_json) }

  describe 'result' do
    it {
      expect(subject['amount']).to eql(resource.amount)
      expect(subject['date']).to eql(resource.created_at.to_formatted_s(:db))
      expect(subject['status']).to eql(resource.success? ? "success" : "failed")
    }
  end
end
