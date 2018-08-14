require 'rails_helper'

describe Subscriptions::CreateSubscription do
  let(:customer) { create(:customer_with_token) }
  let(:form) { Subscriptions::CreateSubscriptionForm.new(subscription_data) }
  subject { described_class.call(form: form, customer: customer) }

  context 'when form is valid' do
    let(:subscription_data) { attributes_for(:subscription) }
    it { expect(subject.success?).to be_truthy }
  end

  context 'when form is invalid' do
    let(:subscription_data) { attributes_for(:invalid_subscription) }
    it { expect(subject.error?).to be_truthy }
  end
end
