require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }
    it { is_expected.to include('plan_id') }
    it { is_expected.to include('created_at') }
    it { is_expected.to include('updated_at') }
  end
end
