require 'rails_helper'

# Test suite for DELETE /api/v1/auth/sign_out
describe 'DELETE /api/v1/auth/sign_out', type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) { { email: user.email, password: user.password } }

  before(:each) do
    user.confirm
    post '/api/v1/auth/sign_in', params: valid_params
  end

  context 'when the access token is valid' do
    before do
      headers = {
        'access-token': response.headers['access-token'],
        'client': response.headers['client'],
        'uid': response.headers['uid']
      }
      delete '/api/v1/auth/sign_out', headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the access token is not valid' do
    before do
      headers = {
        'access-token': 'invalid_token',
        'client': response.headers['client'],
        'uid': response.headers['uid']
      }
      delete '/api/v1/auth/sign_out', headers: headers
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end

    it 'returns a sign out error message' do
      expect(json['errors'][0])
        .to match('User was not found or was not logged in.')
    end
  end
end
