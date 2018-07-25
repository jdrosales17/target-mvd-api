require 'rails_helper'

# Test suite for POST /api/v1/auth/password
describe 'POST /api/v1/auth/password', type: :request do
  let(:user) { create(:user) }

  before(:each) { user.confirm }

  REDIRECT_URL = 'https://www.targetmvd.com'.freeze

  context 'when the request is valid' do
    before do
      post  '/api/v1/auth/password',
            params: {
              email: user.email,
              redirect_url: REDIRECT_URL
            }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a success message' do
      expect(json['message'])
        .to match("An email has been sent to '#{user.email}' containing instructions for resetting your password.")
    end
  end

  context 'when the request is invalid' do
    before do
      post  '/api/v1/auth/password',
            params: {
              email: 'wrong.email@example.com',
              redirect_url: REDIRECT_URL
            }
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a not found error message' do
      expect(json['errors'][0])
        .to match("Unable to find user with email 'wrong.email@example.com'.")
    end
  end
end
