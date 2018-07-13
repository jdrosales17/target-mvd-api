require 'rails_helper'

# Test suite for POST /api/v1/auth
describe 'POST /api/v1/auth', type: :request do
  let(:valid_params)   { attributes_for(:user) }
  let(:invalid_params) { attributes_for(:user, password: '1234') }

  context 'when the request is valid' do
    before { post '/api/v1/auth', params: valid_params }

    it 'creates a user' do
      expect(json['data']).not_to be_empty
      expect(json['data']['email']).to eq(valid_params[:email])
      expect(json['data']['name']).to eq(valid_params[:name])
      expect(json['data']['nickname']).to eq(valid_params[:nickname])
      expect(json['data']['image']['url']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the request is invalid' do
    before { post '/api/v1/auth', params: invalid_params }

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a validation failure message' do
      expect(json['errors']['password'][0])
        .to match('is too short (minimum is 8 characters)')
    end
  end
end
