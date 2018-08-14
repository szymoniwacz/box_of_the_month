require 'rails_helper'

describe Customers::CreateCustomer do
  let(:form) { Customers::CreateCustomerForm.new(customer_data) }
  subject { described_class.call(form: form) }

  context 'when form is valid' do
    let(:customer_data) { attributes_for(:customer) }
    it { expect(subject.success?).to be_truthy }
  end

  context 'when form is invalid' do
    let(:customer_data) { attributes_for(:invalid_customer) }
    it { expect(subject.error?).to be_truthy }
  end
end
