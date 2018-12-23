require 'rails_helper'

describe V1::PlansController, type: :controller do
  describe 'GET #index' do
    context 'responds successfully with an HTTP 200 status code' do
      it {
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      }
    end
  end
end
