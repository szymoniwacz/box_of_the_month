require 'rails_helper'

describe V1::CustomersController, type: :controller do
  describe 'POST #create' do
    context 'when customer attributes valid' do
      let(:valid_customer_data) { attributes_for(:customer) }

      it {
        post :create, params: valid_customer_data
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      }
    end
  end
end
