require 'rails_helper'

# Test suite for POST /auth
describe 'POST /auth', type: :request do
  # valid payload
  let(:valid_params) { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, password: '1234') }

  context 'when the request is valid' do
    before { post '/api/v1/auth', params: valid_params }

    it 'creates a user' do
      expect(json['data']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the request is invalid' do
    before { post '/api/v1/auth', params: invalid_params }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(json['errors']['password'][0])
        .to match('is too short (minimum is 8 characters)')
    end
  end
end
