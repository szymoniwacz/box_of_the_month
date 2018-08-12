require 'rails_helper'

describe Subscriptions::RenewSubscription do
  let(:subscription) { create(:test_subscription_with_payment) }
  subject { described_class.call(subscription_data) }

  context 'when data is valid' do
    let(:subscription_data) { {subscription_id: subscription.id} }
    it { expect(subject.success?).to be_truthy }
  end

  context 'when data is invalid' do
    let(:subscription_data) { {subscription_id: "dummy_id"} }
    it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
