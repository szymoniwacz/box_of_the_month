require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe '.column_names' do
    subject { described_class.column_names }
    it { is_expected.to include('name') }
    it { is_expected.to include('price') }
  end
end
