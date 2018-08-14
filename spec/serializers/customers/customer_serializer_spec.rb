require 'rails_helper'

describe Customers::CustomerSerializer, type: :serializer do
  let(:resource) { create(:customer_with_token) }
  let(:serializer) { described_class.new(resource) }

  subject { JSON.parse(serializer.to_json) }

  describe 'result' do
    it {
      expect(subject['href']).to eql("http://test.host.com/v1/customers/#{resource.id}")
      expect(subject['id']).to eql(resource.id)
      expect(subject['name']).to eql(resource.name)
      expect(subject['address']).to eql(resource.address)
      expect(subject['zip_code']).to eql(resource.zip_code)
      expect(subject['token']).to eql(resource.token.token)
    }
  end
end
