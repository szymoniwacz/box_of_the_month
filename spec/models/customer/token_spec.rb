require 'rails_helper'

RSpec.describe Customer::Token, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }
    it { is_expected.to include('token') }
    it { is_expected.to include('customer_id') }
  end
end
