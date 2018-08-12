require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }
    it { is_expected.to include('token') }
    it { is_expected.to include('success') }
    it { is_expected.to include('error_code') }
    it { is_expected.to include('subscription_id') }
    it { is_expected.to include('amount') }
  end
end
