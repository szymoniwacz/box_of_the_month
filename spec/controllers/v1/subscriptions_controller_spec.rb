require 'rails_helper'

describe V1::SubscriptionsController, type: :controller do
  let(:customer) { create(:customer_with_token) }
  before(:each) { request.headers['Authorization'] = customer.token.token }

  describe "POST #create" do
    context "when subscription attributes valid" do
      let(:valid_subscription_data) { attributes_for(:subscription) }

      it {
        VCR.use_cassette('controllers/subscriptions/create') do
          post :create, params: valid_subscription_data
          expect(response).to be_successful
          expect(response).to have_http_status(201)
        end
      }
    end
  end
end
