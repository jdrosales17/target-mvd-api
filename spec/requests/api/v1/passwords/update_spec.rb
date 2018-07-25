require 'rails_helper'

# Test suite for PUT /api/v1/auth/password
describe 'PUT /api/v1/auth/password', type: :request do
  let(:user) { create(:user) }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before do
      put '/api/v1/auth/password',
          params: {
            password: '12345678',
            password_confirmation: '12345678'
          },
          headers: auth_headers(user)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a success message' do
      expect(json['message'])
        .to match('Your password has been successfully updated.')
    end
  end

  context 'when the access token is not valid' do
    before do
      put '/api/v1/auth/password',
          params: {
            password: '1234',
            password_confirmation: '1234'
          },
          headers: auth_headers(user)
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a validation failure message' do
      expect(json['errors']['password'][0])
        .to match('is too short (minimum is 8 characters)')
    end
  end
end
