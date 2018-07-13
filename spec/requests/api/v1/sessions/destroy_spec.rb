require 'rails_helper'

# Test suite for DELETE /api/v1/auth/sign_out
describe 'DELETE /api/v1/auth/sign_out', type: :request do
  let!(:user) { create(:user) }

  before(:each) { user.confirm }

  context 'when the access token is valid' do
    before { delete '/api/v1/auth/sign_out', headers: auth_headers(user) }

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the access token is not valid' do
    before do
      headers = auth_headers(user)
      headers['access-token'] = 'invalid_token'
      delete '/api/v1/auth/sign_out', headers: headers
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a sign out error message' do
      expect(json['errors'][0])
        .to match('User was not found or was not logged in.')
    end
  end
end
