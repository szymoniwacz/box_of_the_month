require 'rails_helper'

describe V1::SubscriptionsController, type: :controller do
  describe "POST #create" do
    context "when subscription attributes valid" do
      let(:valid_subscription_data) { attributes_for(:subscription) }

      it {
        post :create, params: valid_subscription_data
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      }
    end

    # context "when subscription attributes invalid" do
    #   it {
    #     post :create
    #     expect(json['status']).to eql(400)
    #     expect(json['error']).to eql("validation_failed")
    #     expect(json['message']).to eql("There are some validation errors. Check details object for more info.")
    #   }
    # end
  end
end
